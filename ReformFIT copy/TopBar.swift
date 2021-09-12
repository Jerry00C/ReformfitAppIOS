//
//  TopBar.swift
//  ReformFIT
//
//  Created by J on 2021-08-05.
//

import SwiftUI

struct TopBar: View {
    @Binding var rootActive: Bool
    var titleText: String
    
    var body: some View {
        
        ZStack{
            Color("black")
            HStack{
                NaviView(rootActive: $rootActive)
                
                Spacer()
                
                Text(titleText)
                    .foregroundColor(Color("white"))
                
                Spacer()
                
                NaviView(rootActive: $rootActive)
                    .opacity(0)
                
            
            
            }
            
            .padding(10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 55, alignment: .center)
        
        
        
        
    }
}

struct NaviView: View{
    @Binding var rootActive: Bool
    
    @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View{
        
        HStack{
            Image("Fat Shredder")
                
                .resizable()
                .frame(width: 18, height: 18, alignment: .center)
                .foregroundColor(Color("grey"))
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            
            
            Rectangle()
                .fill(Color("grey"))
                .frame(width: 2)
            
            Image("wifi")
                .resizable()
                .frame(width: 18, height: 18, alignment: .center)
                .foregroundColor(Color("grey"))
                .onTapGesture {
                    rootActive = false
                }
            
            
        }
        .padding(7)
        .background(RoundedRectangle(cornerRadius: 18.0).stroke(Color("grey")))
        
        
    }
}


struct TopBarWOTitle: View{
    
    @Binding var rootActive: Bool
    var body: some View{
        
        VStack{
            HStack{
                NaviView(rootActive: $rootActive)
                    
                Spacer()
            }
            Spacer()
                
        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width, height: 55, alignment: .center)
    }
    
}

struct TopBar_Previews: PreviewProvider {
    
    @State static var rootActive: Bool = false
    static var previews: some View {
        TopBar(rootActive: $rootActive, titleText: "万锦FERRIER试验点")
    }
}
