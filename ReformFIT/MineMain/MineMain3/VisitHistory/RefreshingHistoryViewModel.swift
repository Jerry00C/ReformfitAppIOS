//
//  RefreshingProgressViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-27.
//

import Foundation


class RefreshingHistoryViewModel{
    
    
    @Published var loading = false
    
    var accessToken: String = ""
    
    var limited: Bool
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var visitHistoryRequest: APIRequest<VisitHistoryResource>?
    private var classHistoryRequest: APIRequest<ClassHistoryResource>?
    
    var startDate: String
    var endDate: String
    
    var classIds: [Int]
    
    var classInfoResponse: [Class]
    
    init(){
        
        self.startDate = ""
        self.endDate = ""
        self.limited = false
        self.classIds = []
        self.classInfoResponse = []
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
        
        print("get visit history Info")
        
        let visitHistoryResource = VisitHistoryResource(startDate: self.startDate, endDate: self.endDate)
        visitHistoryRequest = APIRequest<VisitHistoryResource>(resource: visitHistoryResource, requestBody: nil, method: "GET")
        
        visitHistoryRequest?.addAuthKey(authToken: self.accessToken)
        visitHistoryRequest?.execute(){[weak self] response in
            
            
            
            if let realResponse = response?.OnSuccess{
                
                for visit in realResponse.Visits{
                    
                    self?.classIds.append(visit.ClassId ?? 0)
                    
                }
                
                
                
                self?.getClassInfo(onCompletion: onCompletion)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
        }
    }
    
    
    
    
    
    func getClassInfo(onCompletion:@escaping()->Void){
        
        if classIds.count == 0 {
            self.loading = false
            onCompletion()
        }
        else{
            
            let classHistoryResource = ClassHistoryResource(classIds: self.classIds, endDateTime: self.endDate, startDateTime: self.startDate)
            classHistoryRequest = APIRequest<ClassHistoryResource>(resource: classHistoryResource, requestBody: nil, method: "GET")
            
            classHistoryRequest?.addAuthKey(authToken: self.accessToken)
            classHistoryRequest?.execute(){[weak self] response in
                
                print("history on sucess   \(response?.OnSuccess)")
                    print("history on sucess   \(response?.OnError)")
                if let realResponse = response?.OnSuccess{
                    
                    for classEx in realResponse.classes {
                        
                        let timestamp1 = classEx.endTimeStamp
                        let timestamp = Date().timeIntervalSince1970
                            
                            
                        if timestamp1 < timestamp {
                                
                            //print("classId  \(String(describing: classEx.classId))")
                            self?.addInOrder(classEx: classEx, limited: self?.limited ?? false)
                            
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
    
    
    
    
    
    
    func getTimeStamp(dateTime: String) -> Double{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        let fullDate = dateFormatter.date(from: (dateTime.replacingOccurrences(of: "T", with: "")))
        return fullDate!.timeIntervalSince1970
        
        
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
    
}





