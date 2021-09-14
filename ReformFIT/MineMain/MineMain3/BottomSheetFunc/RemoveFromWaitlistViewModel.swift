//
//  RemoveFromWaitlistViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-10.
//

import Foundation



class RemoveFromWaitlistViewModel: ObservableObject{

    
    @Published var loading = false
    
    var waitlistIds: Int = 0
    
            
    private var tokenAPIRequest: MindbodyAPIRequest<TokenResource>?
    private var removeFromWaitlistRequest: MindbodyAPIRequest<RemoveFromWaitlistResource>?
    
    
    func initalize(waitlistIds: Int){
        
        self.waitlistIds = waitlistIds
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.removeFromWaitlist(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func removeFromWaitlist(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        let removeFromWaitlistResource = RemoveFromWaitlistResource(waitlistIds: self.waitlistIds)
        
        removeFromWaitlistRequest = MindbodyAPIRequest<RemoveFromWaitlistResource>(resource: removeFromWaitlistResource, requestBody: nil, method: "POST")
        removeFromWaitlistRequest?.addAuthKey(authToken: authToken)
        removeFromWaitlistRequest?.execute(){[weak self]
            response in
            
            
            if let realResponse = response?.OnSuccess{
                self?.loading = false
                print(realResponse)
                onCompletion()
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                onError(realResponse.error.Message)
            }
            
        }
    }
}


