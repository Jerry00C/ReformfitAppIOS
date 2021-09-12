//
//  AddClientResource.swift
//  ReformFIT
//
//  Created by J on 2021-08-25.
//

import Foundation



struct SignupResource: APIResource{

    
    typealias ResponseModelType = SignupSResponse
    typealias RequestModelType = SignupRequest
    
    var methodPath: String{
        "/public/v6/client/addclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct SignupSResponse: MindbodyResponseType{
    typealias onSuccessResponse = SignupResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}



struct SignupResponse: Decodable{
    
    let Client: Client
}

struct Client: Decodable{
    
    var BirthDate: String?
    var Country: String?
    let CreationDate: String?
    let FirstName: String?
    let Id: String?
    let LastName: String?
    let UniqueId: Int?
    var Email: String?
    var MobilePhone: String?
    var AddressLine1: String?
    var AddressLine2:String?
    var City: String?
    var PostalCode: String?
    var PhotoUrl: String?
    var Gender: String?
    var CustomClientFields: [CustomClientFieldRes]?
    
    
}
extension Client{
    var height: String?{
        guard self.CustomClientFields != nil else {
            return ""
        }
            
        for customClientField in self.CustomClientFields!{
            if customClientField.Name == "Employer"{
                return customClientField.Value
            }
        }
            
        return ""
        
        
    }
    var weight: String?{
        
        guard self.CustomClientFields != nil else {
            return ""
        }
                
        
        for customClientField in self.CustomClientFields!{
            if customClientField.Name == "Health Preferences"{
                return customClientField.Value
            }
        }
        return ""
        
    }
    var wristBandBrand: String?{
        
        guard self.CustomClientFields != nil else {
            return ""
        }
                
        
        for customClientField in self.CustomClientFields!{
            if customClientField.Name == "Contract Canceled"{
                return customClientField.Value
            }
        }
        return ""
        
    }
    var wristBandNum: String?{
        
        guard self.CustomClientFields != nil else {
            return ""
        }
                
        
        for customClientField in self.CustomClientFields!{
            if customClientField.Name == "Progressive Swim Level"{
                return customClientField.Value
            }
        }
        return ""
        
    }
}

struct CustomClientFieldRes: Decodable{
    
    
    var Id: Int
    var Value: String
    var DataType: String
    var Name: String
}


struct SignupRequest: Encodable{
    
    let Email: String
    let FirstName: String
    let LastName: String
    let CustomClientFields : [CustomClientFieldReq]
    let MobilePhone: String
    let PostalCode: String
    let BirthDate: String
    
}

struct CustomClientFieldReq: Encodable{
    
    let Id: Int
    let Value: String
    let DataType: String
    let Name: String
    
}
