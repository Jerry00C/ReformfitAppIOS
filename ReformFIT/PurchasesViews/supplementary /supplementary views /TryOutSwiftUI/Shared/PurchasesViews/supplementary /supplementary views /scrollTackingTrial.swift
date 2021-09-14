//
//  scrollTackingTrial.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-02.
//

import SwiftUI

struct scrollTackingTrial: View {
    @State private var offset = CGFloat.zero
        var body: some View {
            ZStack {
                HStack{
                    Text("\(offset)")
                    Spacer()
                }
                ScrollView {
                    VStack {
                        ForEach(0..<100) { i in
                            Text("Item \(i)").padding()
                        }
                    }.background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                            value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) {
                        offset = $0
                        print("offset >> \($0)") }
                }.coordinateSpace(name: "scroll")
            }
        }
}

struct scrollTackingTrial_Previews: PreviewProvider {
    static var previews: some View {
        scrollTackingTrial()
    }
}


struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
