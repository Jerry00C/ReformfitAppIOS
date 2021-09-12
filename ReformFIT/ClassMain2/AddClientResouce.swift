//
//  AddClientResouce.swift
//  ReformFIT
//
//  Created by J on 2021-08-18.
//

import Foundation


struct AddClientResource: APIResource{
    typealias ResponseModelType = AddClientSResponse
    typealias RequestModelType = AddClientRequest
    
    var methodPath: String{
        "/public/v6/class/addclienttoclass"
    }
//    }
//    let classId: String
//    let clientId: String
    
    var queries: [URLQueryItem]?
//    init(classId: String, clientId: String) {
//        self.classId = classId
//        self.clientId = clientId
//
//
//        var queries: [URLQueryItem]?
//    }
   
    
}



struct AddClientSResponse: MindbodyResponseType{
    typealias onSuccessResponse = AddClientResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}



struct AddClientRequest: Encodable{
    
    let ClientId: String
    let ClassId: String
    let Test: Bool
    let RequirePayment: Bool
    let Waitlist: Bool
    let WaitlistEntryId: Int
    let ClientServiceId: Int
    let CrossRegionalBooking: Bool
    let CrossRegionalBookingClientServiceSiteId: Int
    
    
    
//    URLQueryItem(name: "ClientId", value: self.clientId),
//    URLQueryItem(name: "ClassId", value: self.classId),
//    URLQueryItem(name: "Test", value: "false"),
//    URLQueryItem(name: "RequirePayment", value: "true"),
//    URLQueryItem(name: "Waitlist", value: "true"),
//    URLQueryItem(name: "WaitlistEntryId", value: "0"),
//    URLQueryItem(name: "ClientServiceId", value: "0"),
//    URLQueryItem(name: "CrossRegionalBooking", value: "false"),
//    URLQueryItem(name: "CrossRegionalBookingClientServiceSiteId", value: "0")

    
}


struct AddClientResponse: Decodable{
    
}


