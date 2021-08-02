//
//  PassPurchasingPage.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-31.
//

import SwiftUI

struct PassPurchasingPage: View {
    let serviceName:String
    let serviceInfos:Service?
    var body: some View {
        Text(serviceName)
    }
}

struct PassPurchasingPage_Previews: PreviewProvider {
    static var previews: some View {
        PassPurchasingPage(serviceName: "", serviceInfos: nil)
    }
}
