//
//  RefreshingProgressViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-26.
//

import Foundation



class RefreshingProgressViewModel: ObservableObject{

    
    @Published var loading = false
    
    var accessToken: String = ""
    
    var limited: Bool
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var visitHistoryRequest: APIRequest<VisitHistoryResource>?
    private var waitlistEntriesRequest: APIRequest<WaitlistEntriesResource>?
    private var waitlistEntriesOrderRequest: APIRequest<WaitlistEntriesOrderResource>?
    private var classHistoryRequest: APIRequest<ClassHistoryResource>?
    
    var startDate: String
    var endDate: String
    
    var classIds: [Int]
    var classIdWaitlistEntries: [Int]
    var classIdWrequestTimestamp: [Int: Double]
    var classIdWOrderWaitlist: [Int: Int]
    var classIdWWaitlistId: [Int: Int]
    
    @Published var classInfoResponse: [Class]
    
    init(){
        
        self.startDate = ""
        self.endDate = ""
        self.limited = false
        self.classIds = []
        self.classIdWaitlistEntries = []
        classIdWrequestTimestamp = [:]
        classIdWOrderWaitlist = [:]
        classIdWWaitlistId = [:]
        classInfoResponse = []
    }

    func initialize(startDate: String, endDate: String, limited: Bool) -> Void{
        
        self.startDate = startDate
        self.endDate = endDate
        self.limited = limited
        
    }
    
    func getToken(onCompletion: @escaping()->Void){
        loading = true
        
        if classIds.count != 0{
            classIds = []
        }
        
        if classInfoResponse.count != 0{
            classInfoResponse = []
        }
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.accessToken = realResponse.AccessToken
                self?.getVisitHistoryInfo(onCompletion: onCompletion)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            
            


        }
    }
    
    func getVisitHistoryInfo(onCompletion:@escaping()->Void){
        
        let visitHistoryResource = VisitHistoryResource(startDate: self.startDate, endDate: self.endDate)
        visitHistoryRequest = APIRequest<VisitHistoryResource>(resource: visitHistoryResource, requestBody: nil, method: "GET")
        
        visitHistoryRequest?.addAuthKey(authToken: self.accessToken)
        visitHistoryRequest?.execute(){[weak self]
            response in
           
            
            if let realResponse = response?.OnSuccess{
                for visit in realResponse.Visits{
                    
                    self?.classIds.append(visit.ClassId ?? 0)
                    print("classIds:  \(self?.classIds)")
                }
                
                
                
                self?.getWaitlistEntries(onCompletion: onCompletion)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            
            
            
        }
    }
    
    
    
    func getWaitlistEntries(onCompletion:@escaping()->Void){
       
        let waitlistEntriesResource = WaitlistEntriesResource()
        waitlistEntriesRequest = APIRequest<WaitlistEntriesResource>(resource: waitlistEntriesResource, requestBody: nil, method: "GET")
        
        waitlistEntriesRequest?.addAuthKey(authToken: self.accessToken)
        waitlistEntriesRequest?.execute(){[weak self]
            response in
            
            if let realResponse = response?.OnSuccess{
                for waitlistEntries in realResponse.WaitlistEntries{
                    
                    let classIdEx = waitlistEntries.ClassId ?? 0
                    
                    self?.classIdWaitlistEntries.append(classIdEx)
                    
                    let requestTimestamp = self?.getTimeStamp(dateTime: waitlistEntries.RequestDateTime ?? "")
                    
                    self?.classIdWrequestTimestamp[classIdEx] = requestTimestamp
                    self?.classIdWOrderWaitlist[classIdEx] = 0
                    self?.classIdWaitlistEntries[classIdEx] = waitlistEntries.Id ?? 0
                    
                    
                    
                }
                
                
                
                self?.getWaitlistEntriesOrder(onCompletion: onCompletion)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            
        }
    }
    
    
    
    func getWaitlistEntriesOrder(onCompletion:@escaping()->Void){
        
        let waitlistEntriesOrderResource = WaitlistEntriesOrderResource(classIds: self.classIdWaitlistEntries)
        
        waitlistEntriesOrderRequest = APIRequest<WaitlistEntriesOrderResource>(resource: waitlistEntriesOrderResource, requestBody: nil, method: "GET")
        
        waitlistEntriesOrderRequest?.addAuthKey(authToken: self.accessToken)
        waitlistEntriesOrderRequest?.execute(){[weak self]
            response in
            
            if let realResponse = response?.OnSuccess{
                
                
                for waitlistEntries in realResponse.WaitlistEntries{
                    
                    let classIdEx = waitlistEntries.ClassId ?? 0
                    
                    
                    let requestTimestamp = self?.getTimeStamp(dateTime: waitlistEntries.RequestDateTime ?? "")
                    
                    
                    if globalVariable.clientId == waitlistEntries.clientId{
                        
                        let timestampThresh = self?.classIdWrequestTimestamp[classIdEx]
                        
                        if timestampThresh ?? 0 > requestTimestamp ?? 0 {
                            
                            self?.classIdWOrderWaitlist[classIdEx] = self?.classIdWOrderWaitlist[classIdEx] ?? 0 + 1
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
                
                self?.getClassInfo(onCompletion: onCompletion)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
        }
    }
    
    
    
    func getClassInfo(onCompletion:@escaping()->Void){
        
        self.classIds.append(contentsOf: self.classIdWaitlistEntries)
        
        if classIds.count == 0 {
            self.loading = false
            onCompletion()
        }
        else{
            print("getClassInfo   \(self.classIds)")
            
            let classHistoryResource = ClassHistoryResource(classIds: self.classIds, endDateTime: self.endDate, startDateTime: self.startDate)
            classHistoryRequest = APIRequest<ClassHistoryResource>(resource: classHistoryResource, requestBody: nil, method: "GET")
            
            classHistoryRequest?.addAuthKey(authToken: self.accessToken)
            classHistoryRequest?.execute(){[weak self] response in
                
                if let realResponse = response?.OnSuccess{
                    
                    
                    for classEx in realResponse.classes {
                        var classExCopy = classEx
                        let timestamp1 = classExCopy.endTimeStamp
                        let timestamp = Date().timeIntervalSince1970
                        
                        
                        if timestamp1 > timestamp {
                            
                            if (self?.classIdWaitlistEntries.contains(classEx.classId ?? 0) ?? false){
                                
                                let classIdEx = classExCopy.classId
                                
                                classExCopy.waitlist = true
                                classExCopy.waitlistEntryId = self?.classIdWWaitlistId[classIdEx ?? 0] ?? 0
                                classExCopy.waitlistOrder = self?.classIdWOrderWaitlist[classIdEx ?? 0] ?? 0
                                
                                //print("classId  \(String(describing: classExCopy.classId))")
                                
                            }
                            else{
                                classExCopy.waitlist = false
                            }
                            
                            self?.addInOrder(classEx: classExCopy, limited: self?.limited ?? false)
                            
                        }
                    }
                    self?.loading = false
                    onCompletion()
                    
                }
                else if let realResponse = response?.OnError{
                    
                    print(realResponse.error)
                }
            }
            
        }
    }
    
    
    func addInOrder(classEx: Class, limited: Bool) -> Void{
        
        let timestamp = Date().timeIntervalSince1970
        
        for index in 0..<classInfoResponse.count {
            
            
            let timestamp2 = classInfoResponse[index].startTimestamp
            
            if timestamp <= timestamp2 {
                
                classInfoResponse.insert(classEx, at: index)
                
                if limited {
                    if classInfoResponse.count > 3{
                        classInfoResponse.removeLast()
                        
                    }
                }
                return
                
                
                
            }
            
        }
        
        classInfoResponse.append(classEx)
        
        if limited {
            if classInfoResponse.count > 3{
                classInfoResponse.removeLast()
                
            }
        }
        
        
    }
    
    
    
    
    
    func getTimeStamp(dateTime: String) -> Double{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        let fullDate = dateFormatter.date(from: (dateTime.replacingOccurrences(of: "T", with: "")))
        return fullDate!.timeIntervalSince1970
        
        
    }
    
}



