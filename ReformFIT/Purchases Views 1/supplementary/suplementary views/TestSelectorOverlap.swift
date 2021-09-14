//
//  TestSelectorOverlap.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-06.
//

import SwiftUI

var dropdownCornerRadius:CGFloat = 3.0
struct DropdownOption: Hashable {
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }

    var key: String
    var val: String
}

struct DropdownOptionElement: View {
    var val: String
    var key: String
    @Binding var selectedKey: String
    @Binding var shouldShowDropdown: Bool
    @Binding var displayText: String

    var body: some View {
        Button(action: {
            DispatchQueue.main.async
            {
                withAnimation{
                    self.shouldShowDropdown = false
                    self.displayText = self.val
                    self.selectedKey = self.key
                }
                
            }
        }) {
            VStack(alignment:.leading) {
                HStack {
                    Text(self.val)
                        .font(.system(size: 14))
                    Spacer()
                    if selectedKey == key{
                        Image(systemName: "checkmark")
                    }
                }
                .foregroundColor(selectedKey == key ? .blue : .black)
                Divider()
            }
            .padding(.horizontal)

        }
        
            

    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    @Binding var selectedKey: String
    @Binding var shouldShowDropdown: Bool
    @Binding var displayText: String
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(self.options, id: \.self) { option in
                DropdownOptionElement( val: option.val, key: option.key, selectedKey: self.$selectedKey, shouldShowDropdown: self.$shouldShowDropdown, displayText: self.$displayText)
            }
        }

        .background(Color.white)
        .padding(.top)
        .frame(maxWidth:.infinity)
//        .cornerRadius(dropdownCornerRadius)
        
    }
}

struct DropdownButton: View {
    @State var dropdownWidth:CGFloat = 300
    @State var shouldShowDropdown = false
    @State var displayText: String
    @Binding var selectedKey: String
    var options: [DropdownOption]

    @State var buttonHeight: CGFloat = 30
    var body: some View {
        Button(action: {
            withAnimation{
            self.shouldShowDropdown.toggle()
            }
        }) {
            VStack {
                HStack {
                    Spacer()
                    Text(displayText)
                        .font(.system(size: 15))
                        
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .rotationEffect(.init(degrees: shouldShowDropdown ? 180 :0))
                }
                .foregroundColor(shouldShowDropdown ? .blue : Color("main_background"))
                
            }
        }
        .background(GeometryReader{ geo -> AnyView in
            
            DispatchQueue.main.async {
                let buttonTop = geo.frame(in: .global).minY
                let buttonBottom = geo.frame(in: .global).maxY

                buttonHeight = buttonBottom - buttonTop
            }
            
            
            return AnyView(Spacer().frame(width:0,height:0))
        })
        .padding(.horizontal)
        .cornerRadius(dropdownCornerRadius)
//        .frame(width: self.dropdownWidth, height: self.buttonHeight)
//        .overlay(
//            RoundedRectangle(cornerRadius: dropdownCornerRadius)
//                .stroke(Color.primary, lineWidth: 1)
//        )
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight)
                    Dropdown( options: self.options, selectedKey: self.$selectedKey, shouldShowDropdown: $shouldShowDropdown, displayText: $displayText)
//                        .transition(.move(edge: .top))
                }
            }, alignment: .topLeading
            )
        
    }
}



struct DropdownButton_Previews: PreviewProvider {
    static let options = [
        DropdownOption(key: "week", val: "This week"), DropdownOption(key: "month", val: "This month"), DropdownOption(key: "year", val: "This year")
    ]

    static var previews: some View {
        Group {
            VStack(alignment: .leading) {
                DropdownButton(displayText: "This month", selectedKey: .constant("Test"), options: options)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.green)
            .foregroundColor(Color.primary)

            VStack(alignment: .leading) {

                DropdownButton(shouldShowDropdown: true, displayText: "This month", selectedKey: .constant("Test"), options: options)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
            .foregroundColor(Color.primary)
        }
    }
}
