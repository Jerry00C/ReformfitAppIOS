//
//  CalculatorDropDownSelector.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-05.
//

import SwiftUI

struct CalculatorDropDownSelector: View {
    
    @Binding var expand:Bool
    var body: some View {
        VStack {
            HStack{
                Text("*").foregroundColor(.red)
                +
                Text("年龄:").foregroundColor(Color("main_background"))
                Spacer()
                selectedOption
                    .onTapGesture {
                        withAnimation{
                        expand.toggle()
                        }
                    }
                
                
                
                
                
            }
            
            Divider()
            
        }
        .padding(.horizontal)
        
        
    }
    var selectedOption:some View{
        HStack {
            Text("hello")
            Image(systemName: "arrowtriangle.down.fill")
        }
    }
}

struct CalculatorDropDownSelector_Previews: PreviewProvider {
    static var previews: some View {
        viewTheContent()
    }
}


struct viewTheContent:View{
    let options = [
        DropdownOption(key: "week", val: "This week"), DropdownOption(key: "month", val: "This month"), DropdownOption(key: "year", val: "This year")
    ]
    @State var globalSelectorBottom:CGFloat = 0
    @State var expandSelectot = false
    var body: some View{
        ZStack {
            Color(.white)
            VStack{
                    dummyField()
                        .zIndex(2)
                    CalculatorDropDownSelector(expand: $expandSelectot)
                        .background(GeometryReader{
                            geo -> AnyView in
                            DispatchQueue.main.async {
                                globalSelectorBottom = geo.frame(in: .global).maxY
                            }
                            return AnyView(EmptyView())
                        })
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    DropdownButton(displayText: "This month", selectedKey: .constant("Test"), options: options)
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    dummyField()
                        
                    dummyField()
                   Spacer()
                    
            }
        }
           
            
        
    }
}


struct dummyField: View{
    var body: some View{
        VStack {
            HStack{
                Text("*").foregroundColor(.red)
                +
                Text("年龄:").foregroundColor(Color("main_background"))
                Spacer()
                
            }
            Divider()
        }
        .padding(.horizontal)
    }
}
