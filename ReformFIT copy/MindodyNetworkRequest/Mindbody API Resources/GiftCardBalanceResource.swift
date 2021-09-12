//
//  GiftCardBalanceResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-14.
//

import Foundation

struct GiftCardBalanceResponse: MindbodyResponseType{
    typealias onSuccessResponse = SuccessfulGiftCardBalanceResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
    
}

struct SuccessfulGiftCardBalanceResponse:Decodable{
    let BarcodeId:String
    let RemainingBalance:Double
}


struct GiftCardBalanceRequest: Encodable{
    
}

struct GiftCardBalanceResource: APIResource{
    
    typealias ResponseModelType = GiftCardBalanceResponse
    
    typealias RequestModelType = GiftCardBalanceRequest
    
    var methodPath: String{
        
        "/public/v6/sale/giftcardbalance"
    }
    var queries: [URLQueryItem]?
    
    init(barcodeId:String){
        queries = [
            URLQueryItem(name: "barcodeId", value: barcodeId)
        ]
    }
    
    
}
