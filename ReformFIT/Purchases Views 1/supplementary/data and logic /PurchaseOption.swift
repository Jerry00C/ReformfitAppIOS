//
//  PurchaseOption.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-26.
//

struct PurchaseOption{

    let nameOfPurchase :String
    let price :String
    let purchaseInfos:[String]
    let serviceId:String?
    let contractId:String?
    let purchaseLink:String?
    init(nameOfPurchase :String,price :String,purchaseInfos:[String],serviceId:String?) {
        self.nameOfPurchase = nameOfPurchase
        self.price = price
        self.purchaseInfos = purchaseInfos
        self.serviceId = serviceId
        self.contractId = nil
        self.purchaseLink = nil
    }
    init(nameOfPurchase :String,price :String,purchaseInfos:[String],contractId:String?) {
        self.nameOfPurchase = nameOfPurchase
        self.price = price
        self.purchaseInfos = purchaseInfos
        self.serviceId = nil
        self.contractId = contractId
        self.purchaseLink = nil
    }
    init(nameOfPurchase :String,price :String,purchaseInfos:[String],purchaseLink:String) {
        self.nameOfPurchase = nameOfPurchase
        self.price = price
        self.purchaseInfos = purchaseInfos
        self.serviceId = nil
        self.contractId = nil
        self.purchaseLink = purchaseLink
    }
}
