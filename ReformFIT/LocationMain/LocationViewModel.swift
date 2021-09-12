//
//  LocationViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-03.
//

import Foundation

class LocationViewModel: ObservableObject{

    @Published var obtainedLocation:Location?
    @Published var loading = false
            
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var locationRequest: APIRequest<LocationResource>?
    
    func getToken(onCompletion: @escaping()->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.getLocationInfo(authToken: realResponse.AccessToken,onCompletion: onCompletion)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            
            


        }
    }
    
    func getLocationInfo(authToken: String, onCompletion:@escaping()->Void){
        
        let locationResource = LocationResource()
        locationRequest = APIRequest<LocationResource>(resource: locationResource, requestBody: nil, method: "GET")
        locationRequest?.addAuthKey(authToken: authToken)
        locationRequest?.execute(){[weak self] response in
            
            if let realResponse = response?.OnSuccess{
                let resultLocation = realResponse.locations[0]
                print(resultLocation.address!)
                
                self?.obtainedLocation = resultLocation
                self?.loading = false
                
                onCompletion()
                
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            
        }
    }
}

