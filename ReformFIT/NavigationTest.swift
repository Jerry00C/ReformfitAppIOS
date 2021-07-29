//
//  NavigationTest.swift
//  ReformFIT
//
//  Created by J on 2021-07-28.
//

import SwiftUI

struct NavigationTest: View {
    var body: some View {
        NavigationView{
                NavigationLink(destination: LocationInfo()){
                    LocationExView()
                }
            
        }
    }
}

struct NavigationTest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTest()
    }
}
