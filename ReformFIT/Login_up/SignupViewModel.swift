//
//  AddClientViewModel.swift
//  ReformFIT
//
//  Created by J on 2021-08-25.
//

import Foundation


class SignupViewModel: ObservableObject{

    
    @Published var loading = false
    
    var email: String = ""
    var height: String = ""
    var weight: String = ""
    var fName: String = ""
    var lName: String = ""
    var phoneNum: String = ""
    var postalCode: String = ""
            
    private var tokenAPIRequest: MindbodyAPIRequest<TokenResource>?
    private var signupRequest: MindbodyAPIRequest<SignupResource>?
    
    
    func initalize(email: String, height: String, weight: String, fName: String, lName: String, phoneNum: String, postalCode: String){
        
        self.email = email
        self.height = height
        self.weight = weight
        self.fName = fName
        self.lName = lName
        self.phoneNum = phoneNum
        self.postalCode = postalCode
        
    }
    
    func getToken(onCompletion: @escaping()->Void, onError:@escaping(_ message: String)->Void){
        loading = true
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        tokenAPIRequest = MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
        tokenAPIRequest!.execute{[weak self]  response in
            if let realResponse = response?.OnSuccess{
                print(realResponse.AccessToken)
                self?.signupMindbody(authToken: realResponse.AccessToken,onCompletion: onCompletion, onError: onError)
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                
                onError(realResponse.error.Message)
            }
            
            


        }
    }
    
    func signupMindbody(authToken: String, onCompletion:@escaping()->Void, onError:@escaping(_ message: String)->Void){
        print("signning up")
        let signupResource = SignupResource()
        let customField1 = CustomClientFieldReq(Id: 1, Value: self.height, DataType: "String", Name: "Employer")
        let customField2 = CustomClientFieldReq(Id: 2, Value: self.weight, DataType: "String", Name: "Health Preferences")
        let customField3 = CustomClientFieldReq(Id: 3, Value: "reformfit", DataType: "String", Name: "Contract Canceled")
        
        let customField4 = CustomClientFieldReq(Id: 4, Value: "", DataType: "String", Name: "Progressive Swim Level")
        let requestBody = SignupRequest(Email: self.email, FirstName: self.fName, LastName: lName, CustomClientFields: [customField1, customField2,customField3, customField4], MobilePhone: phoneNum, PostalCode: postalCode, BirthDate: "2000-03-03")
        
        signupRequest = MindbodyAPIRequest<SignupResource>(resource: signupResource, requestBody: requestBody, method: "POST")
        signupRequest?.addAuthKey(authToken: authToken)
        signupRequest?.execute(){[weak self]
            response in
            
            
            if let realResponse = response?.OnSuccess{
                self?.loading = false
                globalVariable.client = realResponse.Client
                onCompletion()
            }
            else if let realResponse = response?.OnError{
                
                print(realResponse.error)
                onError(realResponse.error.Message)
            }
            
        }
    }
}


