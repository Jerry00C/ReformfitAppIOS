//
//  GroupClassPurchaseModel.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-26.
//

import Foundation


struct PurchaseData{
    
    static var purchaseOptions:[String:PurchaseOption]{
        [
            "Premier BURN!":PurchaseOption(
                nameOfPurchase: "Premier BURN!",
                price: "$203/Mo",
                purchaseInfos: ["info1","info2","info3","info4"],
                contractId:"347"
            ),
            "Elite BURN!":PurchaseOption(
                nameOfPurchase: "Elite BURN!",
                price: "$400/Mo",
                purchaseInfos: ["info1","info2","info3","info4"],
                contractId:"347"
            ),
            "Master BURN!":PurchaseOption(
                nameOfPurchase: "Master BURN!",
                price: "$500/Mo",
                purchaseInfos: ["info1","info2","info3"],
                contractId:"347"
            ),
            "20-Class Pass":PurchaseOption(
                nameOfPurchase: "20-Class Pass",
                price: "$203/Mo",
                purchaseInfos: ["info1","info2"],
                serviceId:"1357"
            ),
            "10-Class Pass":PurchaseOption(
                nameOfPurchase: "10-Class Pass",
                price: "$203/Mo",
                purchaseInfos: ["info1","info2"],
                serviceId:"1364"
            ),
            "1-Month Pass":PurchaseOption(
                nameOfPurchase: "1-Month Pass",
                price: "$203/Mo",
                purchaseInfos: ["info1","info2"],
                serviceId:"1357"
            ),
            "Single Pass":PurchaseOption(
                nameOfPurchase: "Single Pass",
                price: "$203/Mo",
                purchaseInfos: ["info1","info2"],
                serviceId:"1300"
            )
        ]
    }
    
}
