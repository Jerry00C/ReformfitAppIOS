//
//  VisitHistoryResouce.swift
//  ReformFIT
//
//  Created by J on 2021-08-26.
//

import Foundation




struct VisitHistoryResource: MindbodyAPIResource{

    
    typealias ResponseModelType = VisitHistorySResponse
    typealias RequestModelType = VisitHistoryRequest
    
    var methodPath: String{
        "/public/v6/client/clientvisits"
    }
    
    
    
    var queries: [URLQueryItem]?
    init(startDate: String, endDate: String) {
        print("id  \(globalVariable.clientId ?? "0")")
        queries = [
            
            URLQueryItem(name: "request.clientId", value: globalVariable.clientId ?? "0"),
            
            URLQueryItem(name: "request.crossRegionalLookup", value: "false"),
            
            URLQueryItem(name: "request.endDate", value: endDate),
            URLQueryItem(name: "request.startDate", value: startDate)
        ]
    }
    
}



struct VisitHistorySResponse: GeneralResponseType{
    typealias onSuccessResponse = VisitHistoryResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}


struct VisitHistoryResponse: Decodable{
    
    let Visits: [Visit]
}


struct Visit: Decodable{
    
    let ClassId: Int?
    
    
}

struct VisitHistoryRequest: Encodable{
    
    
}

