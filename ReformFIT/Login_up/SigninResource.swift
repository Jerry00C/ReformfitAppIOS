//
//  SigninResource.swift
//  ReformFIT
//
//  Created by J on 2021-08-25.
//

import Foundation




struct SigninResource: MindbodyAPIResource{

    
    typealias ResponseModelType = SigninSResponse
    typealias RequestModelType = SigninRequest
    
    var methodPath: String{
        "/public/v6/client/clients"
    }
    var queries: [URLQueryItem]?
    init() {
        
        queries = [
            URLQueryItem(name: "request.clientIDs", value: globalVariable.clientId),
        ]
    }
    
}



struct SigninSResponse: GeneralResponseType{
    typealias onSuccessResponse = SigninResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}


struct SigninResponse: Decodable{
    
    let Clients: [Client]
}

struct SigninRequest: Encodable{
    
    
}
