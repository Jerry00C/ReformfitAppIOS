//
//  GenderViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation


class GenderViewModel: ObservableObject{

    
    @Published var loading = false
    
    
    var gender: String = ""
    
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var genderRequest: APIRequest<GenderResource>?
    
    
    func initalize(gender: String){
        
        
        self.gender = gender
        
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.updateGender(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func updateGender(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let genderResource = GenderResource()
        let client = ClientGender(Id: globalVariable.clientId ?? "", Gender: self.gender)
        let requestBody = GenderRequest(Client: client)
        
        genderRequest = APIRequest<GenderResource>(resource: genderResource, requestBody: requestBody, method: "POST")
        genderRequest?.addAuthKey(authToken: authToken)
        genderRequest?.execute(){[weak self]
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


