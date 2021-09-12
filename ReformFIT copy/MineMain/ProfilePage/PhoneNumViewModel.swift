//
//  PhoneNumViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-31.
//

import Foundation

class PhoneNumViewModel: ObservableObject{

    
    @Published var loading = false
    
    
    var phoneNum: String = ""
    
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var phoneNumRequest: APIRequest<PhoneNumResource>?
    
    
    func initalize(phoneNum: String){
        
        
        self.phoneNum = phoneNum
        
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.updatePhoneNum(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func updatePhoneNum(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let phoneNumResource = PhoneNumResource()
        let client = ClientPhoneNum(Id: globalVariable.clientId ?? "", MobilePhone: self.phoneNum)
        let requestBody = PhoneNumRequest(Client: client)
        
        phoneNumRequest = APIRequest<PhoneNumResource>(resource: phoneNumResource, requestBody: requestBody, method: "POST")
        phoneNumRequest?.addAuthKey(authToken: authToken)
        phoneNumRequest?.execute(){[weak self]
            response in
            
            
            if let realResponse = response?.OnSuccess{
                self?.loading = false
                print("response: \(String(describing: response))")
                onCompletion()
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                onError(realResponse.error.Message)
            }
            
        }
    }
}


