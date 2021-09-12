//
//  ContractResource.swift
//  TryOutSwiftUI
//Contra
//  Created by Chen Chen on 2021-07-29.
//

import Foundation

struct ContractResponse: MindbodyResponseType{
    
    typealias onSuccessResponse = SuccessfulContractResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
}

struct SuccessfulContractResponse: Decodable{
    
    let contracts: [Contract]
    enum CodingKeys: String, CodingKey{
        case contracts = "Contracts"
    }
}

struct Contract:Decodable{
    let contractId: Int
    let contractName: String
    let agreementTerms: String
    let firstSubtotal: Double
    let firstTax: Double
    let firstTotal: Double
    let recurringSubtotal: Double
    let recurringTax: Double
    let recurringTotal: Double
    let contractItems: [ContractItems]
    
    enum CodingKeys: String, CodingKey{
        case contractId = "Id"
        case contractName = "Name"
        case agreementTerms = "AgreementTerms"
        case firstSubtotal = "FirstPaymentAmountSubtotal"
        case firstTax = "FirstPaymentAmountTax"
        case firstTotal = "FirstPaymentAmountTotal"
        case recurringSubtotal = "RecurringPaymentAmountSubtotal"
        case recurringTax = "RecurringPaymentAmountTax"
        case recurringTotal = "RecurringPaymentAmountTotal"
        case contractItems = "ContractItems"
    }
}

struct ContractItems: Decodable{
    let serviceItemId: String
    enum CodingKeys: String, CodingKey{
        case serviceItemId = "Id"
    }
}
struct ContractRequest: Encodable{
    
}

struct ContractResource: APIResource{

    
    typealias ResponseModelType = ContractResponse
    typealias RequestModelType = ContractRequest
    
    var methodPath: String{
        "/public/v6/sale/contracts"
    }
    let contractId: String
    let locationId: Int
    var queries: [URLQueryItem]?
    init(id: String, location: Int) {
        contractId = id
        locationId = location
        queries = [
            URLQueryItem(name: "request.locationId", value: String(locationId)),
            URLQueryItem(name: "request.contractIds", value: contractId)
            

        ]
    }
   
    
}
