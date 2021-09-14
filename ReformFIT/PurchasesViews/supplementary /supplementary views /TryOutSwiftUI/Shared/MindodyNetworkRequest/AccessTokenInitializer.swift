//
//  AccessTokenInitializer.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-09.
//

import Foundation


class AccessTokenInitializer{
    static func constructTokenRequest()->MindbodyAPIRequest<TokenResource>{
        let tokenResource = TokenResource(queries: nil)
        let requestBody = UserTokenRequest(Username: LoginCredential.username, Password: LoginCredential.password)
        return MindbodyAPIRequest<TokenResource>(resource: tokenResource, requestBody: requestBody, method:"POST")
    }
}
