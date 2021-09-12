//
//  LoactionResource.swift
//  ReformFIT
//
//  Created by J on 2021-08-03.
//

import Foundation




struct LocationResource: APIResource{

    
    typealias ResponseModelType = LocationInfoSResponse
    typealias RequestModelType = LocationInfoRequest
    
    var methodPath: String{
        "/public/v6/site/locations"
    }
    var queries: [URLQueryItem]?
   
    
}


struct LocationInfoSResponse: MindbodyResponseType{
    typealias onSuccessResponse = LocationInfoResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}



struct LocationInfoResponse: Decodable{
    
    let locations: [Location]
    enum CodingKeys: String, CodingKey{
        case locations = "Locations"
    }
}

struct Location: Decodable{
    let address: String?
    let address2: String?
    let description: String?
    let lat: Double?
    let lon: Double?
    let name: String?
    let phone: String?
    let postalCode: String?
    
    
    enum CodingKeys: String, CodingKey{
        case address = "Address"
        case address2 = "Address2"
        case description = "Description"
        case lat = "Latitude"
        case lon = "Longitude"
        case name = "Name"
        case phone = "Phone"
        case postalCode = "PostalCode"
    }
    
}

struct LocationInfoRequest: Encodable{
    
}
