//
//  ServiceResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-28.
//

import Foundation


struct ServiceResponse: GeneralResponseType{
    
    typealias onSuccessResponse = SuccessfulServiceResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
}


struct SuccessfulServiceResponse: Decodable{
    
    let services: [Service]
    enum CodingKeys: String, CodingKey{
        case services = "Services"
    }
}

struct Service:Decodable{
    let Id: String
    let Price: Double
    let TaxRate: Double
    
}
struct ServiceRequest: Encodable{
    
}

struct ServiceResource: MindbodyAPIResource{

    
    typealias ResponseModelType = ServiceResponse
    typealias RequestModelType = ServiceRequest
    
    var methodPath: String{
        "/public/v6/sale/services"
    }
    let serviceId: String
    var queries: [URLQueryItem]?
    init(id: String) {
        serviceId = id
        queries = [
            URLQueryItem(name: "request.serviceIds", value: serviceId)
        ]
    }
   
    
}
