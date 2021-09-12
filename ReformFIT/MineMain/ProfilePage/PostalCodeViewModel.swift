//
//  PostalCodeViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation


class PostalCodeViewModel: ObservableObject{

    
    @Published var loading = false
    
    
    var postalCode: String = ""
    
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var postalCodeRequest: APIRequest<PostalCodeResource>?
    
    
    func initalize(postalCode: String){
        
        
        self.postalCode = postalCode
        
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.updatePostalCode(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func updatePostalCode(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let postalCodeResource = PostalCodeResource()
        let client = ClientPostalCode(Id: globalVariable.clientId ?? "", PostalCode: self.postalCode)
        let requestBody = PostalCodeRequest(Client: client)
        
        postalCodeRequest = APIRequest<PostalCodeResource>(resource: postalCodeResource, requestBody: requestBody, method: "POST")
        postalCodeRequest?.addAuthKey(authToken: authToken)
        postalCodeRequest?.execute(){[weak self]
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


