//
//  AccurateSubtraction.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-16.
//

import Foundation


extension Double{
    
    static func accuratelySubtract(value1 x:Double, value2 y:Double)->Double{
        let v1 = Decimal(string: String(x))!
        let v2 = Decimal(string: String(y))!
        
        let substracted = v1 - v2
        return Double(truncating:substracted as NSNumber)
    }
}
