//
//  WeightViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//
//
//  HeightViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation


class WeightViewModel: ObservableObject{

    
    @Published var loading = false
    
    
    var weight: String = ""
    
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var weightRequest: APIRequest<WeightResource>?
    
    
    func initalize(weight: String){
        
        
        self.weight = weight
        
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        
        
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.updateWeight(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func updateWeight(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let weightResource = WeightResource()
        
        let customField = CustomClientFieldReq(Id: 2, Value: self.weight, DataType: "String", Name: "Health Preferences")
        let client = ClientWeight(Id: globalVariable.clientId ?? "", CustomClientFields: customField)
        let requestBody = WeightRequest(Client: client)
        
        weightRequest = APIRequest<WeightResource>(resource: weightResource, requestBody: requestBody, method: "POST")
        weightRequest?.addAuthKey(authToken: authToken)
        weightRequest?.execute(){[weak self]
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


