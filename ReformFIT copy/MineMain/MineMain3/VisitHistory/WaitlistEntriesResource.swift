//
//  WaitlistEntries.swift
//  ReformFIT
//
//  Created by J on 2021-08-26.
//

import Foundation



struct WaitlistEntriesResource: APIResource{

    
    typealias ResponseModelType = WaitlistEntriesSResponse
    typealias RequestModelType = WaitlistEntriesRequest
    
    var methodPath: String{
        "/public/v6/class/waitlistentries"
    }
    
    
    
    var queries: [URLQueryItem]?
    init() {
        
        queries = [
            URLQueryItem(name: "request.clientIds", value: globalVariable.clientId)
        ]
    }
    
}



struct WaitlistEntriesSResponse: MindbodyResponseType{
    typealias onSuccessResponse = WaitlistEntriesResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}


struct WaitlistEntriesResponse: Decodable{
    
    let WaitlistEntries: [WaitlistEntry]
}


struct WaitlistEntry: Decodable{
    
    let ClassId: Int?
    let RequestDateTime: String?
    let Id: Int?
    let Client: Client?
    
    
    
    
}
extension WaitlistEntry{
    
    
    var clientId: String{
        
        return Client?.Id ?? ""
    }
}

struct WaitlistEntriesRequest: Encodable{
    
    
}
