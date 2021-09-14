//
//  BMRCalculationManager.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-03.
//

import Foundation


class BMRCalculationManager: ObservableObject{
    
    @Published var BMRValue:Double?
    var BMRModel:BMRCalculator?
    
    func setBMRModel(gender:String,age:String,height:String,weight:String,bodyFat:String? = nil){
        let model = BMRCalculator(gender: gender, age: Int(age) ?? 1, height: Double(height) ?? 1, weight: Double(weight) ?? 1, bodyFat: bodyFat != "" ? Double(bodyFat!) ?? 15 : nil)
        BMRModel = model
    }
    func calculateBMR(){
        if let model = BMRModel{
            BMRValue = model.calculateBMR()
        }
    }
}
