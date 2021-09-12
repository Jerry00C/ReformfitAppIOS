//
//  AddClientViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-18.
//

import Foundation


class AddClientViewModel: ObservableObject{

    @Published var loading = false
    
    var clientId: String = ""
    var classId: String! = ""
    
   
    init(clientId: String, classId: String){
        self.clientId = clientId
        self.classId = classId
        print("clientId  \(clientId)")
        print("classId   \(classId)")
    }
    
    private var tokenAPIRequest: APIRequest<TokenResource>?
    private var addClientRequest: APIRequest<AddClientResource>?
    
    func addClientToClass(onCompletion: @escaping()->Void){
        
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.addClientToClass2(authToken: realResponse.AccessToken,onCompletion: onCompletion)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            


        }
    }
    func addClientToClass2(authToken: String, onCompletion:@escaping()->Void){
        
        let addClientResource = AddClientResource()
        
        let requestBody = AddClientRequest(ClientId: clientId, ClassId: classId, Test: false, RequirePayment: true, Waitlist: true, WaitlistEntryId: 0, ClientServiceId: 0, CrossRegionalBooking: false, CrossRegionalBookingClientServiceSiteId: 0)
        
        
        addClientRequest = APIRequest<AddClientResource>(resource: addClientResource, requestBody: requestBody, method: "POST")
        addClientRequest?.addAuthKey(authToken: authToken)
        addClientRequest!.execute(){[weak self] response in
            
            
            if let realResponse = response?.OnSuccess{
                
                print(realResponse ?? "")
                
                self?.loading = false
                onCompletion()
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
            
        }
    }
    
    
    func addClientToWaitlist(onCompletion:@escaping()->Void){
        loading = true
        let addClientResource = AddClientResource()
        print("classId : \(String(describing: classId))")
        let requestBody = AddClientRequest(ClientId: clientId, ClassId: classId, Test: false, RequirePayment: true, Waitlist: true, WaitlistEntryId: 0, ClientServiceId: 0, CrossRegionalBooking: false, CrossRegionalBookingClientServiceSiteId: 0)
        
        addClientRequest = APIRequest<AddClientResource>(resource: addClientResource, requestBody: requestBody, method: "POST")
        
        print("Url: \(addClientResource.url)")
        addClientRequest!.execute(){[weak self] response in
           
            
            if let realResponse = response?.OnSuccess{print(response ?? "")
                
                print(realResponse)
                self?.loading = false
                
                onCompletion()
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
            }
        }
    }
}
