//
//  ClassViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-04.
//

import Foundation


class ClassViewModel: ObservableObject{

    @Published var obtainedClassList:[Class]?
    @Published var loading = false
    
    var startDateAndTime: String = ""
    var endDateAndTime: String = ""
    
   
    func setDateAndTime(startDateTime: String, endDateTime: String){
        self.startDateAndTime = startDateTime
        self.endDateAndTime = endDateTime
    }
            
    private var tokenAPIRequest: MindbodyAPIRequest<TokenResource>?
    private var classRequest: MindbodyAPIRequest<ClassResource>?
    
    func getToken(onCompletion: @escaping()->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.getClassInfo(authToken: realResponse.AccessToken,onCompletion: onCompletion)
    
                
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            
//            if let realResponse = response?.OnSuccess{
//                let resultService = realResponse.services[0]
//
//                self?.obtainedService = resultService
//                self?.loading = false
//
//                onCompletion()
//            }
            


        }
    }
    
    func getClassInfo(authToken: String, onCompletion:@escaping()->Void){
        
        let classResource = ClassResource(endDateTime: endDateAndTime, startDateTime: startDateAndTime)
        classRequest = MindbodyAPIRequest<ClassResource>(resource: classResource, requestBody: nil, method: "GET")
        classRequest?.addAuthKey(authToken: authToken)
        classRequest?.execute(){[weak self] response in
           
            
            if let realResponse = response?.OnSuccess{
                
                let resultClass = realResponse.classes
                //print(resultClass)
                
                self?.obtainedClassList = resultClass
                self?.loading = false
                
                onCompletion()
    
                
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
        }
    }
}
