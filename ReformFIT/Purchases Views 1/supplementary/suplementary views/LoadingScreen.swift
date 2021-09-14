//
//  LoadingScreen.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-19.
//

import SwiftUI

struct contentView: View{
    @State var loading: Bool = false
    var body: some View{
        LoadingScreen()
    }
}

struct LoadingScreen: View {
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.5)
                .onTapGesture {
                    withAnimation (.easeOut(duration: 0.1)){
                        
                    }
                }
                .ignoresSafeArea()
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
        }
        
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        contentView()
    }
}
