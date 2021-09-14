//
//  ServicePurchaseResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-06.
//

import Foundation


struct ShoppingCartResponse: GeneralResponseType{
    typealias onSuccessResponse = SuccessfulShoppingCartResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
    
}

struct SuccessfulShoppingCartResponse:Decodable{
    let ShoppingCart:ShoppingCartElement
    
}
struct ShoppingCartElement:Decodable{
    let CartItems: [ResponseCartItem]
    let SubTotal:Double
    let TaxTotal:Double
    let GrandTotal:Double
}
struct ResponseCartItem:Decodable{
    let Quantity:Int
}



struct ShoppingCartRequest:Encodable{
    // Payments[0]--> comp:0
    // Payments[1]--> gift card
    // Payments[3]--> direct debit/stored credit
    
    let ClientId:String
    var Test: Bool
    let Items:[CartItem]
    var PromotionCode: String
    var InStore: Bool
    var Payments: [Payment]
    
    
    mutating func updatePayments(payments:[Payment]){
        self.Payments = payments
    }
    
    func getPromoCode()->String{
        PromotionCode
    }
    
    mutating func updatePromoCode(with newPromoCode:String){
        self.PromotionCode = newPromoCode
    }
    
    mutating func setTestToFalse(){
        self.Test = false
    }
    
    
    
}

struct CartItem: Encodable{
    let Item: RequestCartItem
    let Quantity: Int
    init(serviceId:Int,quantity:Int) {
        self.Item = RequestCartItem(serviceId: serviceId)
        self.Quantity = quantity
    }
}

struct RequestCartItem:Encodable{
    let type: String = "Service"// might not be able to initialize value here
    let metadata: CartItemServiceMetadata
    enum CodingKeys: String, CodingKey{
        case type = "Type"
        case metadata = "Metadata"
    }
    
    init(serviceId:Int) {
        self.metadata = CartItemServiceMetadata(Id: serviceId)
    }
}

struct CartItemServiceMetadata: Encodable{
    let Id: Int
}

enum Payment: Encodable{
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self{
        case .creditCard(let SCartCreditCard):          //likely not used
            try container.encode("CreditCard",forKey: .type)
            try container.encode(SCartCreditCard, forKey: .metadata)
        case .storedCard(let SCartStoredCard):
            try container.encode("StoredCard",forKey: .type)
            try container.encode(SCartStoredCard, forKey: .metadata)
        case .directDebit(let SCartDirectDebit):
            try container.encode("DirectDebit",forKey: .type)
            try container.encode(SCartDirectDebit, forKey: .metadata)
        case .giftCard(let SCartGiftCard):
            try container.encode("GiftCard",forKey: .type)
            try container.encode(SCartGiftCard, forKey: .metadata)
        case .comp(let SCartComp):
            try container.encode("Comp",forKey: .type)
            try container.encode(SCartComp, forKey: .metadata)
        }
    }
    mutating func changeGiftCardAmount(new : Double){
        switch self {
        case .giftCard(var giftCard):
            giftCard.changeAMount(newAmount: new)
            let newGiftCard = giftCard
            self = .giftCard(newGiftCard)
        default:
            return
        }
    }
    
    case creditCard(SCartCreditCard)    // likely not gonna be used
    case storedCard(SCartStoredCard)
    case directDebit(SCartDirectDebit)
    case giftCard(SCartGiftCard)
    case comp(SCartComp)
    enum CodingKeys: String, CodingKey{
        case type = "Type"
        case metadata = "Metadata"
    }
    

    
}


struct SCartCreditCard:Encodable{
    /* likely not gonna be used*/
    var Amount:Double
    let CreditCardNumber:String
    let ExpMonth:Int
    let ExpYear:Int
    let BillingName:String
    let BillingAddress:String
    let BillingCity:String
    let BillingState:String
    let BillingPostalCode:String
    
}

struct SCartStoredCard:Encodable{
    var Amount:Double
    let LastFour:String
}

struct SCartDirectDebit:Encodable{
    var Amount:Double
}

struct SCartComp: Encodable{
    var Amount:Double
}

struct SCartGiftCard: Encodable{
    var Amount:Double
    var CardNumber:String
    
    mutating func changeAMount(newAmount: Double){
        Amount = newAmount
    }
    
}


struct ShoppingCartResource: MindbodyAPIResource{

    
    typealias ResponseModelType = ShoppingCartResponse
    typealias RequestModelType = ShoppingCartRequest
    
    var methodPath: String{
        "/public/v6/sale/checkoutshoppingcart"
    }

    var queries: [URLQueryItem]?
    
   
    
}

