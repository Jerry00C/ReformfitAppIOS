//
//  PrivateLessonPurchasePreview.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-31.
//

import SwiftUI

struct PrivateLessonPurchasePreview: View {
    @State private var PLProceedToPurchase = false
    @State private var CPProceedToPurchase = false
    var topImage: some View {
        Image(systemName: "sparkle")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100.0)
    }
    var body: some View {
        ZStack(){
            Color("main_background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                ZStack{
                    VStack(spacing:20){
                        topImage
                        
                        PrivateLessonPurchaseOptions(proceedToPurchase: $PLProceedToPurchase)
                            .padding(.horizontal)
                        
                        CompPrepPurchaseOptions(proceedToPurchase: $CPProceedToPurchase)
                            .padding(.horizontal)
                        
                    }
                }
            }
        }
    }
}

struct PrivateLessonPurchasePreview_Previews: PreviewProvider {
    static var previews: some View {
        PrivateLessonPurchasePreview()
    }
}

struct PrivateLessonPurchaseOptions: View {
    @Binding var proceedToPurchase: Bool
    @State var chosenOptionName: String?
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(Color("card_background"))
            VStack(alignment: .leading){
                
                PurchaseTypeTitleView(title: "Private Lesson", imageString: "list.bullet")
                
                DividerView(width: 2)
                    .foregroundColor(.blue)
                    .padding(.vertical)
                
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["20-Week Prep"]!)
                    .contentShape(Rectangle())
                    .onTapGesture (perform:{
                        chosenOptionName = "20-Week Prep"
                        proceedToPurchase = true
                        
                    })
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["16-Week Prep"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        chosenOptionName = "16-Week Prep"
                        proceedToPurchase = true

                })
                
                    
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions ["12-Week Prep"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        chosenOptionName = "12-Week Prep"
                        proceedToPurchase = true
                    })
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions ["4-Week Prep"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        chosenOptionName = "4-Week Prep"
                        proceedToPurchase = true

                    })
                NavigationLink(
                    destination: PrivateLessonPurchasingPage(purchaseLink: (PurchaseData.purchaseOptions[chosenOptionName ?? ""]?.purchaseLink) ?? "" , lessonName: chosenOptionName ?? ""),
                    isActive: self.$proceedToPurchase,
                    label: {
                        

                        EmptyView()
                            
                    })
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
            }
            .padding(.all)
            
            
        }
    }
}


struct CompPrepPurchaseOptions: View {
    @Binding var proceedToPurchase: Bool
    @State var chosenOptionName: String?
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(Color("card_background"))
            VStack(alignment: .leading){
                
                PurchaseTypeTitleView(title: "Competition Preperation", imageString: "list.bullet")
                
                DividerView(width: 2)
                    .foregroundColor(.blue)
                    .padding(.vertical)
                
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["100-Session Pack"]!)
                    .contentShape(Rectangle())
                    .onTapGesture (perform:{
                        chosenOptionName = "100-Session Pack"
                        proceedToPurchase = true
                        
                    })
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["75-Session Pack"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        chosenOptionName = "75-Session Pack"
                        proceedToPurchase = true

                })
                
                    
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions ["50-Session Pack"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        chosenOptionName = "50-Session Pack"
                        proceedToPurchase = true
                    })
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions ["Single Session"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        chosenOptionName = "Single Session"
                        proceedToPurchase = true

                    })
                NavigationLink(
                    destination: PrivateLessonPurchasingPage(purchaseLink: (PurchaseData.purchaseOptions[chosenOptionName ?? ""]?.purchaseLink) ?? "", lessonName: chosenOptionName ?? ""),
                    isActive: self.$proceedToPurchase,
                    label: {
                        

                        EmptyView()
                            
                    })
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
            }
            .padding(.all)
            
            
        }
    }
}
