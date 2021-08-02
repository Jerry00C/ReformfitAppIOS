//
//  ContractPurchaseViewModel.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-29.
//

import Foundation


class ContractPurchaseViewModel: ObservableObject{
    
    
    @Published var obtainedContract : Contract?
    private var locationId: Int
    @Published var loading = false
    
    init(locationId:Int) {
        self.locationId = locationId
    }
    
    
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var contractAPIRequest: APIRequest<ContractResource>?
    
    
    func loadContract(contractId:String, onCompletion: @escaping()->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{ [weak self] response in
            if let realResponse = response {
                print(realResponse.AccessToken)
                self?.requestContract(contractId: contractId, authToken: realResponse.AccessToken,onCompletion: onCompletion)
    
                
            }
            


        }
    }
    
    
    func requestContract (contractId: String , authToken: String , onCompletion:@escaping()->Void){
        
        let contractResource = ContractResource(id: contractId, location: locationId)
        
        contractAPIRequest = APIRequest<ContractResource>(resource: contractResource, requestBody: nil, method: "GET")
        contractAPIRequest?.addAuthKey(authToken: authToken)
        print(contractAPIRequest?.requestHeaders ?? "")
        contractAPIRequest?.execute(){[weak self]
            response in
            if let realResponse  = response {
                let resultContract = realResponse.contracts[0]
                self?.obtainedContract = resultContract
                self?.loading = false
                onCompletion()
            }
        
        }
        
        
        
    }
    
    
    
    
    
}

