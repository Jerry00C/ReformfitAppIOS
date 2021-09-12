//
//  HeightResource.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation



struct HeightResource: APIResource{

    
    typealias ResponseModelType = HeightSResponse
    typealias RequestModelType = HeightRequest
    
    var methodPath: String{
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct HeightSResponse: MindbodyResponseType{
    typealias onSuccessResponse = UpdateResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}




struct HeightRequest: Encodable{
    let Client: ClientHeight
    let CrossRegionalUpdate: Bool = false
    let Test: Bool = false
    
}

struct ClientHeight: Encodable{
    let Id: String
    let CustomClientFields: CustomClientFieldReq
    
    
}


