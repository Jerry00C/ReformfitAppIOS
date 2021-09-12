//
//  SigninViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-25.
//

import Foundation

class SigninViewModel: ObservableObject{

    
    @Published var loading = false
    
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var signinRequest: APIRequest<SigninResource>?
    
    
    
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.signinMindbody(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                onError(realResponse.error.Message)
                
            }
        }
    }
    
    func signinMindbody(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        print("signning in")
        let signinResource = SigninResource()
        signinRequest = APIRequest<SigninResource>(resource: signinResource, requestBody: nil, method: "GET")
        signinRequest?.addAuthKey(authToken: authToken)
        signinRequest?.execute(){[weak self]
            response in
            
            
            if let realResponse = response?.OnSuccess{
                self?.loading = false
                globalVariable.client = realResponse.Clients[0]
                globalVariable.clientId = realResponse.Clients[0].Id ?? ""
                globalVariable.logIn = true
                
                onCompletion()
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                onError(realResponse.error.Message)
            }
        }
    }
}


