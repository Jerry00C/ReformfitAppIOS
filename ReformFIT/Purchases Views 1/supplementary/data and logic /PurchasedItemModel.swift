//
//  PurchasedItemModel.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-08-27.
//

import Foundation


struct PurchasedItemModel:Identifiable{
    var id: Int
    
    let saleDate:String
    let description:String
    let totalAmount:String
    
    
    init(purchaseItemId: Int, saleDate:String, description:String, totalAmount:Double) {
        self.id = purchaseItemId
        
        
        self.saleDate = PurchasedItemModel.dateFormatConvert(from: saleDate)
        self.description = description
        
        if totalAmount<0{
            self.totalAmount = "-$" + String((-1)*totalAmount)
        }
        else {
            self.totalAmount = "$" + String(totalAmount)
        }
    }
    
    static private func dateFormatConvert(from date:String)->String{
        let date = String(date.prefix(10))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let newdate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: newdate!)
    }
    
    
}
