//
//  AccessTokenResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-28.
//

import Foundation




struct TokenResource: APIResource{

    
    typealias ResponseModelType = UserTokenResponse
    typealias RequestModelType = UserTokenRequest
    
    var methodPath: String{
        "/public/v6/usertoken/issue"
    }
    var queries: [URLQueryItem]?
   
    
}


struct UserTokenResponse: Decodable{
    let AccessToken: String
}
struct UserTokenRequest: Encodable{
    let Username: String
    let Password: String
    
}


