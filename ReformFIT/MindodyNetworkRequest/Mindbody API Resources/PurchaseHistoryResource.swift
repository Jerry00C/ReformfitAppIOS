//
//  PurchaseHistoryResource.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-08-26.
//

import Foundation

// MARK: response

struct PurchaseHistoryResponse: MindbodyResponseType{
    typealias onSuccessResponse = SuccessfulPurchaseHistoryResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}

struct SuccessfulPurchaseHistoryResponse: Decodable{
    let Purchases: [Purchase]
}


struct Purchase: Decodable{
    let Sale:Sale
}


struct Sale: Decodable{
    let SaleDate: String
    let PurchasedItems: [PurchasedItem]
}

struct PurchasedItem: Decodable{
    
    let Description: String
    let TotalAmount: Double
}



//MARK: request

struct PurchaseHistoryRequest: Encodable{
    let ClientId: String
    var StartDate: String?
    var EndDate: String?
}


struct PurchaseHistoryResource: APIResource{
    typealias ResponseModelType = PurchaseHistoryResponse
    
    typealias RequestModelType = PurchaseHistoryRequest
    
    var methodPath: String{
        
        "/public/v6/client/clientpurchases"
    }
    
    var queries: [URLQueryItem]?
}
