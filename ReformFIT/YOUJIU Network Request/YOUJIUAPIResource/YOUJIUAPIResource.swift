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
    var methodPath: String { get set }
    var queries: [URLQueryItem]? {get set}
    
   
    
}

extension YOUJIUAPIResource {
    var url: URL {
        let baseUrl = "https://open.youjiuhealth.com"
        var components = URLComponents(string: baseUrl)!
        print(methodPath)
        components.path = methodPath
        if queries != nil{
            components.queryItems = queries
        }
        print(components.url!)
        
        return components.url!
    }
}
