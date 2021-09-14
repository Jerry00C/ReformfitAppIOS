//
//  ResponseType.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-06.
//

import Foundation


protocol GeneralResponseType{
    associatedtype onSuccessResponse : Decodable
    associatedtype onErrorResponse :Decodable
    
    var OnSuccess: onSuccessResponse? { get set}
    var OnError: onErrorResponse? { get set }
    init()
}
