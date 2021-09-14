//
//  KeyboardHidingExtension.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-03.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
