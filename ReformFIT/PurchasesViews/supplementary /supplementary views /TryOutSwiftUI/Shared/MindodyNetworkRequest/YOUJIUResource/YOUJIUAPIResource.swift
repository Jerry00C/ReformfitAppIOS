//
//  YOUJIUAPIResource.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-09.
//

import Foundation

protocol YOUJIUAPIResource {
    associatedtype ResponseModelType: GeneralResponseType
    associatedtype RequestModelType: Encodable
    var methodPath: String { get }
    var queries: [URLQueryItem]? {get set}
    
   
    
}

extension YOUJIUAPIResource {
    var url: URL {
        let baseUrl = "https://open.youjiuhealth.com"
        var components = URLComponents(string: baseUrl)!
        components.path = methodPath
        if queries != nil{
            components.queryItems = queries
        }

        
        return components.url!
    }
}
