//
//  PurchaseOption.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-26.
//

import Foundation


struct PurchaseOption{

    let nameOfPurchase :String
    let price :String
    let purchaseInfos:[String]
    let serviceId:String?
    let contractId:String?
    init(nameOfPurchase :String,price :String,purchaseInfos:[String],serviceId:String?) {
        self.nameOfPurchase = nameOfPurchase
        self.price = price
        self.purchaseInfos = purchaseInfos
        self.serviceId = serviceId
        self.contractId = nil
    }
    init(nameOfPurchase :String,price :String,purchaseInfos:[String],contractId:String?) {
        self.nameOfPurchase = nameOfPurchase
        self.price = price
        self.purchaseInfos = purchaseInfos
        self.serviceId = nil
        self.contractId = contractId
    }
}
