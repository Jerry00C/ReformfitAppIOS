//
//  BMICalculationManager.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-05.
//

import Foundation

class BMICalculationManager:ObservableObject{
    @Published var BMIValue:Double?
    var BMIModel:BMICalculator?
    
    func setBMIModel(height:String,weight:String){
        let model = BMICalculator(weight: Double(weight) ?? 1, height: Double(height) ?? 1)
        BMIModel = model
    }
    func calculateBMI(){
        if let model = BMIModel{
            BMIValue = model.calculate()
        }
    }
}
