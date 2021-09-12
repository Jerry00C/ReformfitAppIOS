//
//  ClientInfo.swift
//  ReformFIT
//
//  Created by J on 2021-08-18.
//

import Foundation

var globalVariable: GlobalVariable = GlobalVariable()

class GlobalVariable{
    
    var logIn: Bool
    var clientId: String?
    var client: Client?
    
    init(){
        logIn = false
        
    }
    
}
