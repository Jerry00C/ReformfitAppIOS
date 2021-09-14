//
//  RemoveClientFromClassViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-10.
//

import Foundation


class RemoveClientFromClassViewModel: ObservableObject{

    
    @Published var loading = false
    
    var clientId: String = ""
    var classId: Int = 0
    var lateCancel: Bool = false
            
    private var tokenAPIRequest: MindbodyAPIRequest<TokenResource>?
    private var removeClientFromClassRequest: MindbodyAPIRequest<RemoveClientFromClassResource>?
    
    
    func initalize(clientId: String, classId: Int, lateCancel: Bool){
        
        self.clientId = clientId
        self.classId = classId
        self.lateCancel = lateCancel
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.removeClientFromClass(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func removeClientFromClass(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let removeClientFromClassResource = RemoveClientFromClassResource()
        
        
        let requestBody = RemoveClientFromClassRequest(ClientId: self.clientId, ClassId: self.classId, LateCancel: self.lateCancel)
        
        removeClientFromClassRequest = MindbodyAPIRequest<RemoveClientFromClassResource>(resource: removeClientFromClassResource, requestBody: requestBody, method: "POST")
        removeClientFromClassRequest?.addAuthKey(authToken: authToken)
        removeClientFromClassRequest?.execute(){[weak self]
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


