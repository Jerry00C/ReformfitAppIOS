//
//  MindbodyAPIRequest.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-28.
//

import Foundation


class APIRequest<Resource: APIResource> {
    let resource: Resource
    let requestBody_: Resource.RequestModelType?
    let method: String
    var requestHeaders: [String : String] = ["Content-Type":"application/json",
         "API-KEY":"75d68925737844f4ac6a7d990ac11414",
         "SiteId":"-99"
    ]
    init(resource: Resource, requestBody: Resource.RequestModelType?,method:String) {
        self.resource = resource
        self.requestBody_ = requestBody
        self.method = method
    }
    deinit {
        print("request:\(self) for method \(method) is deinitialized")
    }
}
 
extension APIRequest: NetworkRequest {
    


    
    
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
        load(resource.url, requestBody: requestBody_, withCompletion: completion)
    }
}

extension APIRequest{
    func addAuthKey(authToken authorization:String)->Void{
        requestHeaders["Authorization"]=authorization
    }
}
