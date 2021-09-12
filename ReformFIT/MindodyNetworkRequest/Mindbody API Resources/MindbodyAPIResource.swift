//
//  MindbodyAPIResource.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-27.
//

import Foundation



protocol APIResource {
    associatedtype ResponseModelType: MindbodyResponseType
    associatedtype RequestModelType: Encodable
    var methodPath: String { get }
    var queries: [URLQueryItem]? {get set}
    
   
    
}

extension APIResource {
    var url: URL {
        let baseUrl = "https://api.mindbodyonline.com"
        var components = URLComponents(string: baseUrl)!
        components.path = methodPath
        if queries != nil{
            components.queryItems = queries
        }

        
        return components.url!
    }
}
