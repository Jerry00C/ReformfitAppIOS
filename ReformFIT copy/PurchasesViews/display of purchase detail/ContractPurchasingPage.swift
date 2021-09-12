//
//  ContractPurchasingPage.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-31.
//

import SwiftUI

struct ContractPurchasingPage: View {
    
    let contractName: String
    let contractInfos: Contract?
    var body: some View {
        Text(contractName)
        Text(contractInfos?.agreementTerms ?? "nothing for now")

    }
}

struct ContractPurchasingPage_Previews: PreviewProvider {
    static var previews: some View {
        ContractPurchasingPage(contractName: "Contract Name ", contractInfos: nil)
    }
}
