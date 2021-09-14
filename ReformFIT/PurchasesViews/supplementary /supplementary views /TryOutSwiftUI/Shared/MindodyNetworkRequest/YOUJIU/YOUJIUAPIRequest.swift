//
//  YOUJIUAPIRequest.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-09.
//

import Foundation


class YOUJIUAPIRequest<Resource: YOUJIUAPIResource>{
    let resource: Resource
    let requestBody_: Resource.RequestModelType?
    let method: String
    var requestHeaders: [String : String]? = nil
    init(resource: Resource, requestBody: Resource.RequestModelType?,method:String) {
        self.resource = resource
        self.requestBody_ = requestBody
        self.method = method
    }
}

extension YOUJIUAPIRequest: NetworkRequest {
    


    
    
    typealias ResponseType = Resource.ResponseModelType
    typealias RequestType = Resource.RequestModelType
    var requestMethod: String{
       method
    }
    
    func encode(_ requestBody: RequestType) -> Data {
        let jsonData = try? JSONEncoder().encode(requestBody)
        print("encoded data:\(String(decoding: jsonData!, as: UTF8.self))")

        return jsonData!
    }

    
    func decode(_ data: Data) -> ResponseType {
        var responseModel:ResponseType = ResponseType()
            
        responseModel.OnSuccess = try? JSONDecoder().decode(Resource.ResponseModelType.onSuccessResponse.self, from: data)
        
        responseModel.OnError = try?JSONDecoder().decode(Resource.ResponseModelType.onErrorResponse.self, from: data)
        return responseModel
    }
    
    func execute(withCompletion completion: @escaping (ResponseType?) -> Void) {
        print(resource.url)
        load(resource.url, requestBody: requestBody_, withCompletion: completion)
    }
}
