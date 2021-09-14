//
//  WristBandNumViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-09-07.
//

import Foundation


class WristBandNumViewModel: ObservableObject{

    
    @Published var loading = false
    
    
    var wristBandNum: String = ""
    
            
    private var tokenAPIRequest: MindbodyAPIRequest<TokenResource>?
    private var wristBandNumRequest: MindbodyAPIRequest<WristBandNumResource>?
    
    
    func initalize(wristBandNum: String){
        
        
        self.wristBandNum = wristBandNum
        
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        
        
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.updateWristBandNum(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func updateWristBandNum(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        
        let wristBandNumResource = WristBandNumResource()
        
        let customField = CustomClientFieldReq(Id: 4, Value: self.wristBandNum, DataType: "String", Name: "Progressive Swim Level")
        let client = ClientWristBandNum(Id: globalVariable.clientId ?? "", CustomClientFields: customField)
        let requestBody = WristBandNumRequest(Client: client)
        
        wristBandNumRequest = MindbodyAPIRequest<WristBandNumResource>(resource: wristBandNumResource, requestBody: requestBody, method: "POST")
        wristBandNumRequest?.addAuthKey(authToken: authToken)
        wristBandNumRequest?.execute(){[weak self] response in
            
            
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


