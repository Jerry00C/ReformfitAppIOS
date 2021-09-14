//
//  AccessTokenResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-28.
//

import Foundation




struct TokenResource: MindbodyAPIResource{
    

    
    typealias ResponseModelType = UserTokenResponse
    typealias RequestModelType = UserTokenRequest
    
    var methodPath: String{
        "/public/v6/usertoken/issue"
    }
    var queries: [URLQueryItem]?
   
    
}


struct UserTokenResponse: GeneralResponseType{
    typealias onSuccessResponse = SuccessfulTokenResponse
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}
struct UserTokenRequest: Encodable{
    let Username: String
    let Password: String
    
}

struct SuccessfulTokenResponse: Decodable{
    let AccessToken: String
}


