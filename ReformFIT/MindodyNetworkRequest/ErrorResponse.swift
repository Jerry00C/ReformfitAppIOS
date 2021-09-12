//
//  ErrorResponse.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-06.
//

import Foundation


struct ErrorResponse: Decodable{
    let error: Error
    enum CodingKeys: String, CodingKey{
        case error = "Error"
    }
}

struct Error: Decodable{
    let Message:String
    let Code:String
}
