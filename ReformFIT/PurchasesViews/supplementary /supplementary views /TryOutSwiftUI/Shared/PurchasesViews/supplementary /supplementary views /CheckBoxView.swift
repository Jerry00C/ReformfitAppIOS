//
//  CheckBoxView.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-04.
//

import SwiftUI

struct TemporaryContentView: View{
    @State var isSelected:Bool
    
    var body: some View{
        
        CheckBox(selected: $isSelected, color: Color("gray"))

    }
}

struct CheckBox: View {

    @Binding var selected: Bool
    var color: Color

    var body: some View {
        ZStack{
            if selected{
                Image(systemName: "circle.fill")
                    .foregroundColor(Color("white"))
            }
            Button(action: { self.selected.toggle() }) {
                Image(systemName: self.selected == true ? "checkmark.circle.fill" : "circle")
            }
            .accentColor(self.selected == true ? self.color : Color("white"))
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        TemporaryContentView(isSelected: false)
        
    }
}
