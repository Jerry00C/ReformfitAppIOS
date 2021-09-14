//
//  YOUJIUTokenResource.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-09.
//

import Foundation

struct YOUJIUTokenRequest:Encodable{
    
}

struct YOUJIUTokenResponse:GeneralResponseType{
    typealias onSuccessResponse = SuccessfulYOUJIUTokenResponse
    
    typealias onErrorResponse = YOUJIUErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
}

struct SuccessfulYOUJIUTokenResponse: Decodable{
    let access_token :String
    let token_type: String
    let expires_in: Int
}
struct YOUJIUTokenResource: YOUJIUAPIResource{
    
    static private let app_id = "977771291791745"
    static private let app_secret = "ZTkyMWU3ODljZWViZmI0NTA0MzA0MTcxNTRkMzM2OTY1ODg0N2UyZQ"

    
    typealias ResponseModelType = YOUJIUTokenResponse
    typealias RequestModelType = YOUJIUTokenRequest
    
    
    var methodPath: String{
        "/api/session"
    }
    var queries: [URLQueryItem]?
    
    init(){
        queries = [
            URLQueryItem(name: "app_id", value: YOUJIUTokenResource.app_id),
            URLQueryItem(name: "app_secret", value: YOUJIUTokenResource.app_secret)
        ]
    }
    
   
    
}
