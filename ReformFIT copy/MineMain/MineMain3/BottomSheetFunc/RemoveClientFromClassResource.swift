//
//  RemoveClientFromClass.swift
//  ReformFIT
//
//  Created by J on 2021-09-10.
//

import Foundation



struct RemoveClientFromClassResource: APIResource{

    
    typealias ResponseModelType = RemoveClientFromClassSResponse
    typealias RequestModelType = RemoveClientFromClassRequest
    
    var methodPath: String{
        "/public/v6/class/removeclientfromclass"
    }
    var queries: [URLQueryItem]?
   
    
}


struct RemoveClientFromClassSResponse: MindbodyResponseType{
    typealias onSuccessResponse = RemoveClientFromClassResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}



struct RemoveClientFromClassResponse: Decodable{
    
}



struct RemoveClientFromClassRequest: Encodable{
    
    let ClientId: String
    let ClassId: Int
    let Test: Bool = false
    let SendEmail: Bool = false
    let LateCancel: Bool
    
}

