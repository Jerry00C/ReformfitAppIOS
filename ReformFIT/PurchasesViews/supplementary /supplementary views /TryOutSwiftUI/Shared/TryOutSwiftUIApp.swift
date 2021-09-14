//
//  TryOutSwiftUIApp.swift
//  Shared
//
//  Created by Chen Chen on 2021-07-20.
//

import SwiftUI

@main
struct TryOutSwiftUIApp: App {
    let servicePurchaseViewModel = ServicePurchaseViewModel()
    var body: some Scene {
        WindowGroup {
//            PurchaseTabsView()
//            BMRCalculatorView()
//            GroupClassPurchasePreview(servicePurchaseViewModel: servicePurchaseViewModel,contractPurchaseViewModel: ContractPurchaseViewModel(locationId: 1))
            YOUJIUReportPage()
        }
    }
}
