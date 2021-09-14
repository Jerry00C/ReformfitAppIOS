//
//  ModalDialogView.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-10.
//

import SwiftUI

struct ModalDialogView<Content: View>: View {
    @Binding var showModal: Bool
    let title:String="title"
    let cancelText:String
    let confirmText:String
    let content: Content // content of the modal
    
    var onConfirm: ()->Void
    var onCancel: ()-> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .onTapGesture {
                    withAnimation (.easeOut(duration: 0.1)){
                        self.showModal.toggle()
                        onCancel()
                    }
                }
                .ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    Color.gray.opacity(0.2),
                                    lineWidth: 1)
                    )
                    .shadow(color: Color.gray.opacity(0.4), radius: 4)
//                    .coordinateSpace(name: "cardView")
                
                
                VStack {
                    VStack(spacing:20) {
                        Title
                        content
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    
                    HStack {
                        
                        ModalCancelButton(
                            text:cancelText,
                            showModal: self.$showModal,
                            action: onCancel
                        )
                            
                            
                        Spacer().frame(width: 0.0)
                        ModalConfirmButton(
                            text: confirmText,
                            showModal: self.$showModal,
                            action: onConfirm
                        )

                        
                    }
                }
                
                
            }
//            .ignoresSafeArea()
            .fixedSize()
            
        }
//        .ignoresSafeArea()
    }
    
    var Title: some View{
        Text(title)
            .font(.title)
    }
}


extension ModalDialogView{
    
    struct ModalCancelButton: View {
        let text: String
        @Binding var showModal: Bool
        var action: ()->Void
        
        var body: some View {
            // button to search a new handle
            Button(action: {
                withAnimation(.easeOut(duration: 0.1)){
                    self.showModal.toggle()
                }
                self.action()
                print("close modal")
            }) {
                ZStack {
                    RoundedCorners(color: Color("gray"),tl: 0,tr: 0,bl: 30,br: 0)
                        .frame(width:150)
                Text(text)
                    .foregroundColor(Color("white"))
                    .font(.headline)
                    .padding()
                    .shadow(color: Color.gray.opacity(0.5), radius: 8)
                }
            }
        }
    }
    
    struct ModalConfirmButton: View {
        let text:String
        @Binding var showModal: Bool
        var action: ()->Void
        
        var body: some View {
            // button to search a new handle
            Button(action: {
//                withAnimation(.easeOut(duration: 0.1)){
//                    self.showModal.toggle()
//                }
                self.action()
                print("close modal")
            }) {
                ZStack {
                    RoundedCorners(color: Color("yellow"),tl: 0,tr: 0,bl: 0,br: 30)
                        .frame(width:150)
                    Text(text)
                        .foregroundColor(Color("main_background"))
                        .font(.headline)
                        .padding()
                        .shadow(color: Color.gray.opacity(0.5), radius: 8)
                }
                    
                
            }
        }
    }

    
}

struct ModalDialogView_Previews: PreviewProvider {
    static var previews: some View {
        ModalDialogView(
            showModal: .constant(false),
            cancelText: "Cancel",
            confirmText:"Confirm",
            content:
                VStack {
                    Text("Content")
                    Text("Content")

                },
            onConfirm:{},
            onCancel:{}
        )
        
    }
}





