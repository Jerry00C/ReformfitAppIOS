//
//  GetClientDirectDebit.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-18.
//

import Foundation


struct GetClientDirectDebitResponse: GeneralResponseType{
    typealias onSuccessResponse = SuccessfulDirectDebitResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
    
}

struct SuccessfulDirectDebitResponse:Decodable{
    let NameOnAccount: String
    let RoutingNumber: String
    let AccountNumber: String
    let AccountType: String
}


struct GetClientDirectDebitRequest: Encodable{
    
}

struct GetClientDirectDebitResource: MindbodyAPIResource{
    typealias ResponseModelType = GetClientDirectDebitResponse
    
    typealias RequestModelType = GetClientDirectDebitRequest
    
    var methodPath: String{
        
        "/public/v6/client/clientdirectdebitinfo"
    }
    var queries: [URLQueryItem]?
    
    init(clientId:String){
        queries = [
            URLQueryItem(name: "clientId", value: clientId)
        ]
    }
    
    
    
}
