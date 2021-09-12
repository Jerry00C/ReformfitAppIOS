//
//  CheckView.swift
//  ReformFIT
//
//  Created by J on 2021-08-31.
//

import SwiftUI

struct CheckView: View {
    @Binding var checked: Bool
    var body: some View {
        if checked {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(Color("yellow"))
                .onTapGesture {
                    print("click")
                    checked.toggle()
                }
        }
        else{
            Circle().strokeBorder(Color("grey"), lineWidth: 2)
                .frame(width: 15, height: 15)
                .onTapGesture {
                    print("click")
                    checked.toggle()
                    
                }
        }
    }
}

struct CheckView_Previews: PreviewProvider {
    @State static var checked = false
    static var previews: some View {
        CheckView(checked: $checked)
    }
}
