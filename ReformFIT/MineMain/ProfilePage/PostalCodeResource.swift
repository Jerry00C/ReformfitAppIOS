//
//  PostalCodeResource.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation


struct PostalCodeResource: APIResource{

    
    typealias ResponseModelType = PostalCodeSResponse
    typealias RequestModelType = PostalCodeRequest
    
    var methodPath: String{
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct PostalCodeSResponse: MindbodyResponseType{
    typealias onSuccessResponse = UpdateResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}




struct PostalCodeRequest: Encodable{
    let Client: ClientPostalCode
    let CrossRegionalUpdate: Bool = false
    let Test: Bool = false
    
}

struct ClientPostalCode: Encodable{
    let Id: String
    let PostalCode: String
    
    
}


