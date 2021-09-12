//
//  PhoneNumResource.swift
//  ReformFIT
//
//  Created by J on 2021-08-27.
//

import Foundation



struct PhoneNumResource: APIResource{

    
    typealias ResponseModelType = PhoneNumSResponse
    typealias RequestModelType = PhoneNumRequest
    
    var methodPath: String{
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct PhoneNumSResponse: MindbodyResponseType{
    typealias onSuccessResponse = UpdateResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}


struct UpdateResponse: Decodable{
    
}



struct PhoneNumRequest: Encodable{
    let Client: ClientPhoneNum
    let CrossRegionalUpdate: Bool = false
    let Test: Bool = false
    
}

struct ClientPhoneNum: Encodable{
    let Id: String
    let MobilePhone: String
    
    
}

