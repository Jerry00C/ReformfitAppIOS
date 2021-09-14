//
//  RadioGroupButton.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-03.
//

import SwiftUI

struct RadioGroupButton: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RadioGroup: View{
    let buttonNumber:Int = 2
    let buttonNames:[String]
    @Binding var selectedButton:String
    
    var body: some View{
        HStack{
            ForEach(buttonNames, id: \.self){ name in
                RadioButton(selected: $selectedButton, color: Color("rare_gray"), name: name)
            }
        }
    }
}


struct RadioButton: View {

    @Binding var selected: String
    var color: Color
    var name: String

    var body: some View {
        HStack {
            Text(name)
                .foregroundColor(Color("gray"))
            ZStack{
                if selected == self.name{
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color("white"))
                }
                Button(action: { self.selected = self.name }) {
                    Image(systemName: self.selected == self.name ? "checkmark.circle.fill" : "circle")
                }
                .accentColor(self.selected == self.name ? self.color : Color("white"))
            }
        }
    }
}


struct RadioGroupButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioGroupButton()
    }
}
