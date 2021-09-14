//
//  PresentationContext.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-13.
//

import Foundation
import SwiftUI

//public class PresentationContext<Content>: ObservableObject {
//    
//    public init() {}
//    
//    @Published public var isActive = false
//    
//    public var isActiveBinding: Binding<Bool> {
//        .init(get: { self.isActive },
//              set: { self.isActive = $0 }
//        )
//    }
//    
//    open func content() -> Content { contentView! }
//    
//    public internal(set) var contentView: Content? {
//        didSet { isActive = contentView != nil }
//    }
//    
//    public func dismiss() {
//        isActive = false
//    }
//    
//    public func present(_ content: Content) {
//        contentView = content
//    }
//}
