//
//  BirthDateResource.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation



struct BirthDateResource: APIResource{

    
    typealias ResponseModelType = BirthDateSResponse
    typealias RequestModelType = BirthDateRequest
    
    var methodPath: String{
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct BirthDateSResponse: MindbodyResponseType{
    typealias onSuccessResponse = UpdateResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}




struct BirthDateRequest: Encodable{
    let Client: ClientBirthDate
    let CrossRegionalUpdate: Bool = false
    let Test: Bool = false
    
}

struct ClientBirthDate: Encodable{
    let Id: String
    let BirthDate: String
    
    
}


