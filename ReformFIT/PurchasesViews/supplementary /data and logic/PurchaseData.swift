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
            ,
            "20-Week Prep":PurchaseOption(
                nameOfPurchase: "20-Week Prep",
                price: "$3300",
                purchaseInfos: ["info1","info2","info3"],
                purchaseLink: "https://acorn.utoronto.ca"
            ),
            "16-Week Prep":PurchaseOption(
                nameOfPurchase: "16-Week Prep",
                price: "$2680",
                purchaseInfos: ["info1","info2","info3"],
                purchaseLink: "https://ferrari.com"
            ),
            "12-Week Prep":PurchaseOption(
                nameOfPurchase: "12-Week Prep",
                price: "$2040",
                purchaseInfos: ["info1","info2","info3"],
                purchaseLink: "https://lamborghini.com"
            ),
            "4-Week Prep":PurchaseOption(
                nameOfPurchase: "4-Week Prep",
                price: "$700",
                purchaseInfos: ["info1","info2","info3"],
                purchaseLink: "https://leagueoflegends.com"
            ),
            "100-Session Pack":PurchaseOption(
                nameOfPurchase: "100-Session Pack",
                price: "$6500",
                purchaseInfos: ["info1","info2"],
                purchaseLink: "https://apple.com"
            ),
            "75-Session Pack":PurchaseOption(
                nameOfPurchase: "75-Session Pack",
                price: "$5062.5",
                purchaseInfos: ["info1","info2"],
                purchaseLink: "https://google.com"
            ),
            "50-Session Pack":PurchaseOption(
                nameOfPurchase: "50-Session Pack",
                price: "$3500",
                purchaseInfos: ["info1","info2"],
                purchaseLink: "https://pornhub.com"
            ),
            "Single Session":PurchaseOption(
                nameOfPurchase: "Single Pass",
                price: "$75",
                purchaseInfos: ["info1","info2"],
                purchaseLink: "https://nhentai.net"
            )
        ]
    }
    
}
