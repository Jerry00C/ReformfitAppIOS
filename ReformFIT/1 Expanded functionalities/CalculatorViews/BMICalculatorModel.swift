//
//  BMICalculatorModel.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-05.
//

import Foundation


struct BMICalculator{
    var weight:Double
    var height:Double
    
    func calculate()->Double{
        weight/pow((height/100),2 )
    }
}
