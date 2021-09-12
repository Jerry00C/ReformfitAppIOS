//
//  GenderResource.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation



struct GenderResource: APIResource{

    
    typealias ResponseModelType = GenderSResponse
    typealias RequestModelType = GenderRequest
    
    var methodPath: String{
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct GenderSResponse: MindbodyResponseType{
    typealias onSuccessResponse = UpdateResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}




struct GenderRequest: Encodable{
    let Client: ClientGender
    let CrossRegionalUpdate: Bool = false
    let Test: Bool = false
    
}

struct ClientGender: Encodable{
    let Id: String
    let Gender: String
    
    
}


