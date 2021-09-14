//
//  YOUJIUReportManager.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-12.
//

import Foundation


class YOUJIUReportManager:ObservableObject{
    
    
    
    func initializeToken(onCompletion:@escaping()->Void){
        let tokenResource = YOUJIUTokenResource()
        let tokenRequest = YOUJIUAPIRequest(resource: tokenResource, requestBody: nil, method: "POST")
        tokenRequest.execute(){
            response in
            if let successResponse = response?.OnSuccess{
                print(successResponse.access_token)
            }
        }
    }
}
