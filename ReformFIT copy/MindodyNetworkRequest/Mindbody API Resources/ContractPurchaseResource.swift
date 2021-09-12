//
//  ContractPurchaseResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-21.
//

import Foundation



struct ContractPurchaseResponse: MindbodyResponseType{
    typealias onSuccessResponse = SuccessfulContractPurchaseResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}


struct SuccessfulContractPurchaseResponse: Decodable{
    let ClientId: String
    let LocationId: Int
    let ContractId: Int
    let ClientContractId: Int?
    let PaymentProcessingFailures: [PaymentProcessingFailure]?
}


struct PaymentProcessingFailure: Decodable{
    let type: String
    let message: String
    let authentificationRedirectUrl: String
    enum CodingKeys: String, CodingKey{
        case type = "Type"
        case message = "Message"
        case authentificationRedirectUrl = "AuthentificationRedirectUrl"
    }
}


struct ContractPurchaseRequest: Encodable{
    var Test:Bool
    let LocationId: Int
    let ClientId:String
    let ContractId: Int
    var StartDate: String?
    var firstPaymentOccurs: String
    var PromotionCode: String
    var UseDirectDebit: Bool
    var StoredCardInfo: ContractPurchaseStoredCardInfo?
    let SendNotification: Bool
    
    mutating func setStoredCard(lastFour: String){
        self.UseDirectDebit = false
        self.StoredCardInfo = ContractPurchaseStoredCardInfo(LastFour: lastFour)
    }
    
    mutating func setDirectDebit(){
        self.UseDirectDebit = true
        self.StoredCardInfo = nil
    }
    
    mutating func setTestToFalse(){
        self.Test = false
    }
    
    mutating func updatePromoCode(with newCode: String){
        self.PromotionCode = newCode
    }
    
    mutating func updateStartDate(with newDateInString: String){
        self.StartDate = newDateInString
    }
    
    
}

struct ContractPurchaseStoredCardInfo: Encodable{
    var LastFour: String
}


struct ContractPurchaseResource: APIResource{
    typealias ResponseModelType = ContractPurchaseResponse
    
    typealias RequestModelType = ContractPurchaseRequest
    
    var methodPath: String{
        "/public/v6/sale/purchasecontract"
    }
    
    var queries: [URLQueryItem]?
    
    
}
