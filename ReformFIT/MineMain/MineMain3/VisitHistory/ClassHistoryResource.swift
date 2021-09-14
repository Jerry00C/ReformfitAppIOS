//
//  ClassHistoryResource.swift
//  ReformFIT
//
//  Created by J on 2021-08-26.
//

import Foundation

struct ClassHistoryResource: MindbodyAPIResource{
    typealias ResponseModelType = ClassInfoSResponse
    typealias RequestModelType = ClassInfoRequest
    
    var methodPath: String{
        "/public/v6/class/classes"
    }
    
    var queries: [URLQueryItem]?
    
    init(classIds: [Int], endDateTime: String, startDateTime: String) {
        queries = []
        for classId in classIds {
            print("classId:  \(classId)")
            queries?.append(URLQueryItem(name: "request.classIds", value: String(classId)))
        
        }
        queries?.append(URLQueryItem(name: "request.endDateTime", value: endDateTime))
        queries?.append(URLQueryItem(name: "request.startDateTime", value: startDateTime))
            
        
        
        
        print("queries:   \(String(describing: queries))")
    }
    
    
    
}


