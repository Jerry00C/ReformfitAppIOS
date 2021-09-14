//
//  RmoveFromWaitlist.swift
//  ReformFIT
//
//  Created by J on 2021-09-10.
//

import Foundation



struct RemoveFromWaitlistResource: MindbodyAPIResource{

    
    typealias ResponseModelType = RemoveFromWaitlistSResponse
    typealias RequestModelType = RemoveFromWaitlistRequest
    
    var methodPath: String{
        "/public/v6/class/removefromwaitlist"
    }
    var queries: [URLQueryItem]?
    
    init(waitlistIds: Int){
        
        queries = [
            URLQueryItem(name: "request.waitlistEntryIds", value: "\(waitlistIds)"),
        ]
        
        
    }
   
    
}


struct RemoveFromWaitlistSResponse: GeneralResponseType{
    typealias onSuccessResponse = RemoveFromWaitlistResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}



struct RemoveFromWaitlistResponse: Decodable{
    
}



struct RemoveFromWaitlistRequest: Encodable{
    
    
}

