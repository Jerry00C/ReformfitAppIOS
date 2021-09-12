//
//  UpdateClientDirectDebitResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-18.
//

import Foundation


struct AddClientDirectDebitResponse: MindbodyResponseType{
    typealias onSuccessResponse = SuccessfulDirectDebitResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
    
}




struct AddClientDirectDebitRequest: Encodable{
    let Test: Bool
    var ClientId:String
    var NameOnAccount: String
    var RoutingNumber: String
    var AccountNumber: String
    var AccountType: String
}

struct AddClientDirectDebitResource: APIResource{
    typealias ResponseModelType = AddClientDirectDebitResponse
    
    typealias RequestModelType = AddClientDirectDebitRequest
    
    var methodPath: String{
        
        "/public/v6/client/addclientdirectdebitinfo"
    }
    var queries: [URLQueryItem]?
        
}
