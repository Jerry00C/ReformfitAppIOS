
//
//  GiftCardBalanceResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-14.
//

import Foundation

struct GetClientCreditCardResponse: MindbodyResponseType{
    typealias onSuccessResponse = SuccessfulGetCerditCardResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
    
}

struct SuccessfulGetCerditCardResponse:Decodable{
    let Clients:[CreditCard_Client]
}

struct CreditCard_Client:Codable{ //MARK: maybe try this and the upper one to codable for both encoding and decoding to save some lines of code
    let ClientCreditCard:ClientCreditCardInfo?
    let Id:String
}
struct ClientCreditCardInfo:Codable{
    var Address:String
    var CardHolder:String
    var CardNumber:String
    var CardType:String
    var City:String
    var ExpMonth:String
    var ExpYear:String
    var LastFour:String{
        String(CardNumber.suffix(4))
    }
    var PostalCode:String
    var State:String
    
}


struct getClientCreditCardRequest: Encodable{
    
}

struct GetClientCreditCardResource: APIResource{
    
    typealias ResponseModelType = GetClientCreditCardResponse
    
    typealias RequestModelType = getClientCreditCardRequest
    
    var methodPath: String{
        
        "/public/v6/client/clients"
    }
    var queries: [URLQueryItem]?
    
    init(clientId:String){
        queries = [
            URLQueryItem(name: "request.clientIDs", value: clientId)
        ]
    }
    
    
}
