//
//  AccessTokenInitializer.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-09.
//

import Foundation


class AccessTokenInitializer{
    static func constructTokenRequest()->APIRequest<TokenResource>{
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        return APIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
    }
}
