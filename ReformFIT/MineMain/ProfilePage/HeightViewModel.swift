//
//  HeightViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation


class HeightViewModel: ObservableObject{

    
    @Published var loading = false
    
    
    var height: String = ""
    
            
    private var tokenAPIRequest: MindbodyAPIRequest<TokenResource>?
    private var heightRequest: MindbodyAPIRequest<HeightResource>?
    
    
    func initalize(height: String){
        
        
        self.height = height
        
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        
        
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.updateHeight(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func updateHeight(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let heightResource = HeightResource()
        
        let customField = CustomClientFieldReq(Id: 1, Value: self.height, DataType: "String", Name: "Employer")
        let client = ClientHeight(Id: globalVariable.clientId ?? "", CustomClientFields: customField)
        let requestBody = HeightRequest(Client: client)
        
        heightRequest = MindbodyAPIRequest<HeightResource>(resource: heightResource, requestBody: requestBody, method: "POST")
        heightRequest?.addAuthKey(authToken: authToken)
        heightRequest?.execute(){[weak self]
            response in
            
            
            if let realResponse = response?.OnSuccess{
                self?.loading = false
                print("response: \(String(describing: realResponse))")
                onCompletion()
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                onError(realResponse.error.Message)
            }
            
        }
    }
}


