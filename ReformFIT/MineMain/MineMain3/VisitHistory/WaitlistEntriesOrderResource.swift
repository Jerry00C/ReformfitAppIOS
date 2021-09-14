//
//  WaitlistEntriesOrderResource.swift
//  ReformFIT
//
//  Created by J on 2021-08-26.
//

import Foundation



struct WaitlistEntriesOrderResource: MindbodyAPIResource{

    
    typealias ResponseModelType = WaitlistEntriesOrderSResponse
    typealias RequestModelType = WaitlistEntriesOrderRequest
    
    var methodPath: String{
        "/public/v6/class/waitlistentries"
    }
    
    
    
    var queries: [URLQueryItem]?
    init(classIds: [Int]) {
        
        queries = [
            URLQueryItem(name: "request.clientIds", value: globalVariable.clientId),
            
           
        ]
        for classId in classIds {
        
            queries?.append(URLQueryItem(name: "request.clsaaIds", value: String(classId)))
        
        }
    }
    
}


struct WaitlistEntriesOrderSResponse: GeneralResponseType{
    typealias onSuccessResponse = WaitlistEntriesOrderResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}

struct WaitlistEntriesOrderResponse: Decodable{
    let WaitlistEntries :[WaitlistEntry]
}



struct WaitlistEntriesOrderRequest: Encodable{
    
    
}


