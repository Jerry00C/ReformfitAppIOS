//
//  WristBandNumResource.swift
//  ReformFIT
//
//  Created by J on 2021-09-07.
//

import Foundation

struct WristBandNumResource: MindbodyAPIResource{

    
    typealias ResponseModelType = WristBandNumSResponse
    typealias RequestModelType = WristBandNumRequest
    
    var methodPath: String{
        "/public/v6/client/updateclient"
    }
    var queries: [URLQueryItem]?
   
    
}


struct WristBandNumSResponse: GeneralResponseType{
    typealias onSuccessResponse = UpdateResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}



struct WristBandNumRequest: Encodable{
    let Client: ClientWristBandNum
    let CrossRegionalUpdate: Bool = false
    let Test: Bool = false
    
}

struct ClientWristBandNum: Encodable{
    let Id: String
    let CustomClientFields: CustomClientFieldReq
    
    
}
