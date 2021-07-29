//
//  MainTest.swift
//  ReformFIT
//
//  Created by J on 2021-07-26.
//

import SwiftUI

enum Tab{
    case first
    case second
    case third
    case fourth
}

struct Main: View {
    @State var selectedTab: Tab = .first
    @State var fab: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    var btnBack: some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
    
    
        
    var body: some View {
        
        
        NavigationView{
            
         ZStack {
             Color("black").zIndex(0)
             VStack{
                 switch selectedTab{
                     case .first:
                         LocationMain(fab: $fab)
                         
                     case .second:
                         ClassMain()
                             
                     case .third:
                         SocialMain()
                             
                     case .fourth:
                         VideoMain()
                         
                 }
                 
                 CustomTabView(selectedTab: $selectedTab, fab:$fab)
                             .frame(height: 50)
                     .opacity(fab ? 0 : 1)
                 
                 
             }.zIndex(1)
                 
             if fab{
                
                MineMain()
                    .transition(.move(edge: .bottom))
                    .zIndex(2)
                 
                 
             }
             VStack{
                 ClassMain().opacity(0)
                 
                 fabView(fab: $fab)
                 
             }.zIndex(3)
         }
         .background(Color("black"))
         .navigationBarTitleDisplayMode(.inline)
                 .toolbar { // <2>
                     ToolbarItem(placement: .principal) { // <3>
                         VStack {
                             Text("Title").font(.headline)
                             Text("Subtitle").font(.subheadline)
                         }
                     }
                 }
        }
    }
}

struct CustomTabView: View{
    @Binding var selectedTab: Tab
    @Binding var fab: Bool
    
    var body: some View{
        
        HStack{
            tabItemView(selectedTab: $selectedTab, tabOrder: .first, image: "wifi", text: "Location")
            
                
            tabItemView(selectedTab: $selectedTab, tabOrder: .second, image: "wifi", text: "Schedule")
            
            
            fabView(fab: $fab).opacity(0)
            
            
            tabItemView(selectedTab: $selectedTab, tabOrder: .third, image: "wifi", text: "Community")
            
            
            tabItemView(selectedTab: $selectedTab, tabOrder: .fourth, image: "wifi", text: "Video")
            
            Spacer()
            
            
        }
        .padding(.vertical, 8)
        .background(Color("black"))
        
            
        
    }
}

struct MainTest_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

struct tabItemView: View{
    @Binding var selectedTab: Tab
    var tabOrder: Tab
    var image: String
    var text: String
    
    
    var body: some View{
        Spacer()
        
        Button{
            selectedTab = tabOrder
            
        }label:{
            VStack {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                Text(text)
                    .font(.caption2)
            }
        }
        .foregroundColor(selectedTab == tabOrder ? Color("yellow") : Color("grey") )
        
        
    }
}

struct fabView: View{
    @Binding var fab: Bool
    
    var body: some View{
        
        Spacer()
        
        
        Button{
            withAnimation{
                fab.toggle()
                
            }
            
        }label:{
            ZStack{
                Circle()
                    .foregroundColor(Color("yellow"))
                    .frame(width: 50, height: 50)
                    .shadow(radius: 2)
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(Color("black"))
                    .frame(width: 42, height: 42)
                
                
            }
            .offset(y: -32)
        }
        
        
    }
    

}


