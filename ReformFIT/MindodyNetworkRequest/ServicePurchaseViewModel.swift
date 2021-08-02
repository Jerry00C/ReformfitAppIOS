//
//  ServicePurchaseViewModel.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-28.
//

import Foundation

class ServicePurchaseViewModel: ObservableObject{

    @Published var obtainedService:Service?
    @Published var loading = false
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var serviceAPIRequest: APIRequest<ServiceResource>?
    
    func LoadService(serviceId:String, onCompletion: @escaping()->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response {
                print(realResponse.AccessToken)
                self?.requestService(serviceId: serviceId, authToken: realResponse.AccessToken,onCompletion: onCompletion)
    
                
            }
            


        }
    }
    
    func requestService(serviceId: String, authToken: String, onCompletion:@escaping()->Void){
        
        let serviceResource = ServiceResource(id: serviceId)
        serviceAPIRequest = APIRequest<ServiceResource>(resource: serviceResource, requestBody: nil, method: "GET")
        serviceAPIRequest?.addAuthKey(authToken: authToken)
        serviceAPIRequest?.execute(){[weak self]
            response in
            if let realResponse = response{
                let resultService = realResponse.services[0]
                
                self?.obtainedService = resultService
                self?.loading = false
                
                onCompletion()
            }
        }
    }
}
