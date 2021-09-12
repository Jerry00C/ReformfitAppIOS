//
//  UpdateCreditCardResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-17.
//

import Foundation


struct UpdateCreditCardResponse: MindbodyResponseType{
    typealias onSuccessResponse = SuccessfulUpdateCreditCardResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
    
}


struct SuccessfulUpdateCreditCardResponse: Decodable{
    let Client: CreditCard_Client
    
}


struct UpdateCreditCardRequest:Encodable{
    let Client:CreditCard_Client
    let CrossRegionalUpdate:Bool
    let Test:Bool
}

struct UpdateCreditCardResource:APIResource{
    typealias ResponseModelType = UpdateCreditCardResponse
    
    typealias RequestModelType = UpdateCreditCardRequest
    
    var methodPath: String{
        
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
    

}
