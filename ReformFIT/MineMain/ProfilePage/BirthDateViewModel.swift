//
//  BirthDateViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation



class BirthDateViewModel: ObservableObject{

    
    @Published var loading = false
    
    
    var birthDate: String = ""
    
            
    private var tokenAPIRequest: MindbodyAPIRequest<TokenResource>?
    private var birthDateRequest: MindbodyAPIRequest<BirthDateResource>?
    
    
    func initalize(birthDate: String){
        
        
        self.birthDate = birthDate
        
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.updateBirthDate(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func updateBirthDate(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let birthDateResource = BirthDateResource()
        let client = ClientBirthDate(Id: globalVariable.clientId ?? "", BirthDate: self.birthDate)
        let requestBody = BirthDateRequest(Client: client)
        
        birthDateRequest = MindbodyAPIRequest<BirthDateResource>(resource: birthDateResource, requestBody: requestBody, method: "POST")
        birthDateRequest?.addAuthKey(authToken: authToken)
        birthDateRequest?.execute(){[weak self]
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


