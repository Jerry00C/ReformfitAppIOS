//
//  KeyBoardAdaptive.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-11.
//


//MARK: this keyboard adaptive is not used currenty

import Foundation
import SwiftUI
import Combine

struct KeyboardAdaptive:ViewModifier{
    @State private var bottomPadding: CGFloat = 0
    
    func body(content: Content) -> some View{
        GeometryReader { geometry in
                    content
                        .padding(.bottom, self.bottomPadding)
                        // 2.
                        .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                            // 3.
                            let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                            print("\nkeyboard top:\(keyboardTop)")
                            // 4.
                            let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                            print("textinput bottom:\(focusedTextInputBottom)")
                            // 5.
                            self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
                                .rounded()
                            print("bottom padding\(self.bottomPadding)")
                    }
                    // 6.
                    .animation(.easeOut(duration: 0.16))
        }
    }
}


extension View {
    func keyboardAdaptive() -> some View{
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
