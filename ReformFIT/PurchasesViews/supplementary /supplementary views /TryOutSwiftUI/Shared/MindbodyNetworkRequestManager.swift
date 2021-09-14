//
//  MindbodyNetworkRequestManager.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-27.
//

import Foundation


class NetworkRequestManager{
    
    
    private var accessToken: String?
    
    private let baseUrl = "https://api.mindbodyonline.com/public/v6/"
    private let username = "_ReformFIT"
    private let password = "WEBdeveloper123!"
    private let contentType_key = "Content-Type"
    private let contentType_value = "application/json"
    private let apiKey_key = "API-KEY"
    private let apiKey_value = "75d68925737844f4ac6a7d990ac11414"
    private let siteId_key = "SiteId"
    private let siteId_value = "-99"
    
    func obtainAccessToken(withCompletion completion: @escaping ()->Void){
        let requestBody = UserTokenRequest(Username: username, Password: password)
        let jsonData = try? JSONEncoder().encode(requestBody)
        let url = URL(string: baseUrl+"usertoken/issue")
        guard let requestUrl = url else{fatalError()}
        var tokenRequest = URLRequest(url: requestUrl)
        tokenRequest.httpMethod = "POST"
        tokenRequest.setValue(contentType_value, forHTTPHeaderField: contentType_key)
        tokenRequest.setValue(apiKey_value, forHTTPHeaderField: apiKey_key)
        tokenRequest.setValue(siteId_value, forHTTPHeaderField: siteId_key)
        tokenRequest.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: tokenRequest) { (data, response, error) in
                
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                guard let data = data else {return}
                do{
                    let responseModel = try JSONDecoder().decode(UserTokenResponse.self, from: data)
                    print("user token:\n \(responseModel.AccessToken)")
                    
                }catch let jsonErr{
                    print(jsonErr)
               }
         
        }
        task.resume()

    }
    
    struct UserTokenResponse: Decodable{
        let AccessToken: String
    }

    struct UserTokenRequest: Encodable{
        let Username: String
        let Password: String
        
    }
}



