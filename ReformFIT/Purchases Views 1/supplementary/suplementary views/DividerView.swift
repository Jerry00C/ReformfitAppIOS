//
//  DividerView.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-25.
//

import SwiftUI

struct DividerView: View {
    let color: Color = Color("grey")
    let width: CGFloat
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
    }
}


