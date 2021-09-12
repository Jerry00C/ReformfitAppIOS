//
//  BottomSheetView.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-15.
//

import SwiftUI

struct ContentView: View{
    @State var cardShown = false
    @State var cardDismissal = false
    var body: some View{
        ZStack {
            Button(action: {
                withAnimation{
                    cardShown.toggle()
                }
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            BottomSheetView(cardShown:$cardShown, cardDismissal: $cardDismissal,offset:300, whenExpanded: 0){
                CardContent()
            }
            .edgesIgnoringSafeArea(.bottom)
        }

    }
    
}

struct CardContent: View{
    var body: some View{
        VStack{
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Spacer()
                    Text("Button")
                    Spacer()
                }
                .padding(.vertical)
            })
            Spacer()
                .frame(height:0)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Spacer()
                    Text("Button")
                    Spacer()
                }
                .padding(.vertical)
            })
            
            DividerView(width: 4)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Spacer()
                    Text("Button")
                    Spacer()
                }
                .padding(.vertical)
            })
        }
        
    }
}

struct BottomSheetView<Content: View>: View {
    let content: Content
    let offset: CGFloat
    let offsetWhenExpanded: CGFloat
    
    @Binding var cardShown : Bool
    @Binding var cardDismissal : Bool

    init(cardShown: Binding<Bool>,cardDismissal: Binding<Bool>,offset: CGFloat,whenExpanded: CGFloat,@ViewBuilder content:()->Content){
        _cardShown = cardShown
        _cardDismissal = cardDismissal
        self.content = content()
        self.offset = offset
        self.offsetWhenExpanded = whenExpanded
    }
    var body: some View {
        ZStack{
            
            GeometryReader{_ in
                EmptyView()
                
            }
            .background(Color.black.opacity(0.6))
            .opacity(cardShown ? 0.8 : 0)
            .animation(.easeIn)
            .ignoresSafeArea()
            .onTapGesture {
                // dismiss
                withAnimation(){
                    cardShown.toggle()
                }
                
            }
            
            //card
            VStack {
                Spacer()
                VStack {
                    content
                        .background(RoundedCorners(color: .white, tl: 20, tr: 20, bl: 0, br: 0))
                }
                .offset(y: cardShown ? 0 : offset)
//                .transition(.move(edge: .bottom))
//                    .ignoresSafeArea(edges:.bottom)
            }
            
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    
    

    static var previews: some View {
        ContentView(cardShown: true, cardDismissal: true)
        
    }
}
