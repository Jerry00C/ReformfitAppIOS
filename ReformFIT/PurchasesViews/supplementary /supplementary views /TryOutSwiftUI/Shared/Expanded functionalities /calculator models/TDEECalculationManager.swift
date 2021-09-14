//
//  TDEECalculationManager.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-06.
//

import Foundation


class TDEECalculationManager:ObservableObject{
    @Published var TDEEResult:Double?
    var BMRModel:BMRCalculator?
    
    func setBMRModel(gender:String,age:String,height:String,weight:String,bodyFat:String? = nil){
        let model = BMRCalculator(gender: gender, age: Int(age) ?? 1, height: Double(height) ?? 1, weight: Double(weight) ?? 1, bodyFat: bodyFat != "" ? Double(bodyFat!) ?? 15 : nil)
        BMRModel = model
    }
    
    func calculateTDEE(activityLevel:String){
        if let model = BMRModel{
            if activityLevel == "sedentary"{
                TDEEResult = model.calculateBMR()*1.2
            }
            else if activityLevel == "light"{
                TDEEResult = model.calculateBMR()*1.375
            }
            else if activityLevel == "moderate"{
                TDEEResult = model.calculateBMR()*1.55
            }
            else if activityLevel == "high"{
                TDEEResult = model.calculateBMR()*1.725
            }
            else if activityLevel == "extreme"{
                TDEEResult = model.calculateBMR()*1.9
            }
            TDEEResult = round(TDEEResult!*100)/100
        }
    }
}

//DropdownOption(key: "none", val: "久坐，没啥运动><"),
//DropdownOption(key: "light", val: "轻量，每周运动1-3次"),
//DropdownOption(key: "mediocre", val: "中强度，每周运动3-5次"),
//DropdownOption(key: "high", val: "高强度，每周运动6-7次"),
//DropdownOption(key: "extreme", val: "极强，无时无刻都在运动")
