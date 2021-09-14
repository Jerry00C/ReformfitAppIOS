//
//  WeightResource.swift
//  ReformFIT
//
//  Created by J on 2021-09-01.
//

import Foundation




struct WeightResource: MindbodyAPIResource{

    
    typealias ResponseModelType = WeightSResponse
    typealias RequestModelType = WeightRequest
    
    var methodPath: String{
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct WeightSResponse: GeneralResponseType{
    typealias onSuccessResponse = UpdateResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}




struct WeightRequest: Encodable{
    let Client: ClientWeight
    let CrossRegionalUpdate: Bool = false
    let Test: Bool = false
    
}

struct ClientWeight: Encodable{
    let Id: String
    let CustomClientFields: CustomClientFieldReq
    
    
}
