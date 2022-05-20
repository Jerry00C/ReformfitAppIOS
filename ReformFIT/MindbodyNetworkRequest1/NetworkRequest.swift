//
//  NetworkRequest.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-28.
//

import Foundation


protocol NetworkRequest: AnyObject {
    associatedtype ResponseType:GeneralResponseType
    associatedtype RequestType
    var requestMethod:String {get }
    var requestHeaders: [String: String]? {get set}
    func encode(_ requestBody: RequestType) -> Data
    func decode(_ data: Data) -> ResponseType
    func execute(withCompletion completion: @escaping (ResponseType?) -> Void)
}

extension NetworkRequest {
    
    

    func load(_ url: URL, requestBody:RequestType?, withCompletion completion: @escaping (ResponseType?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        request.allHTTPHeaderFields = requestHeaders
        if let realRequestBody = requestBody{
            request.httpBody = encode(realRequestBody)
        }
        
        let task = URLSession.shared.dataTask(with: request) { /*[weak self]*/ (data, response , error) -> Void in
//            guard let self = self else{print("return")
//                return}
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let data = data /*,let value = self?.decode(data)*/ else {
                DispatchQueue.main.async { completion(nil) }
                print("Failed")
                return
            }
            //print("data:\(String(decoding: data, as: UTF8.self))")
            let value = self.decode(data)
            //print(value)
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}
