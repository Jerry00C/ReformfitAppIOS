//
//  BMRCalculatorModel.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-03.
//

import Foundation


struct BMRCalculator{
    var gender:String
    var age:Int
    var height:Double
    var weight:Double
    var bodyFat: Double?
    
    func calculateBMR()->Double{
        if let enteredBodyFat = bodyFat{
            return (370+(21.6*(weight*(100-enteredBodyFat)/100)))
        }
        else {
            if gender == "男"{
                let v1 = (10*weight)
                let v2 = (6.25*height)
                let v3 = (5*age)
                return (v1+v2-Double(v3)+5)
            }
            else {
                let v1 = (10*weight)
                let v2 = (6.25*height)
                let v3 = (5*age)
                return (v1+v2-Double(v3) - 161)
            }
        }
    }
}
