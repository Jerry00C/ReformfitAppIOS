//
//  PrivateLessonPurchasingPage.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-01.
//

import SwiftUI

struct PrivateLessonPurchasingPage: View {
    
    let purchaseLink:String
    let lessonName: String
    var lessonInfos: PurchaseOption{
        PurchaseData.purchaseOptions [lessonName]!
    }
    @State var proceedToPayment = false
    @State var isAgreementChecked = false
    @State var fullNameConfirm: String = ""
    @ObservedObject var avoider = KeyboardAvoider()
    
    var initialSubtotal:Double{
        extractPrice(message:lessonInfos.price)
    }
    
    var initialTax:Double{
        round(initialSubtotal*0.13)
    }
    
    var initialTotal:Double{
        initialSubtotal+initialTax
    }
    
    var body: some View {
        ZStack{
            Color("main_background")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                ScrollView{
                    VStack(spacing:20){
                        PurchaseGeneralInfos(purchaseName: lessonName)
                            .padding(.horizontal)
                        PrivateLessonPriceDisplay(
                            subtotal: initialSubtotal,
                            tax: initialTax,
                            total: initialTotal
                        )
                        .padding(.horizontal)
                        PurchaseAgreementDisplay(isAgreementChecked: $isAgreementChecked,enteredName:$fullNameConfirm, avoider: avoider)
                            .padding(.horizontal)
                        NavigationLink(
                            destination: WebView(url: URL(string: purchaseLink)).ignoresSafeArea(edges: .bottom),
                            isActive: self.$proceedToPayment,
                            label: {
                                

                                EmptyView()
                                    
                            })
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        
                        
                        Spacer()
                            .frame(height: 10.0)
                        
                    }
                }
                .attachKeyboardAvoider(avoider, offset: 0)
                .registerKeyboardAvoider(avoider)
                
                bottomConfirmButton
            }
            .ignoresSafeArea(edges:.bottom)
        }
    }
    var bottomConfirmButton: some View{
        Button(action: {
            if isAgreementChecked/* && fullNameConfirm != ""*/{
                proceedToPayment.toggle()
            }
            else {
                // give out a message for agreement check 
            }
        },
               label: {
                ZStack {
                    Color("yellow")

                        
                    Text("前往付款")
                        .layoutPriority(-1)
                        .foregroundColor(Color("main_background"))
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    
                }
        })
            .frame(height: UIScreen.main.bounds.height/20)
    }
    
    private func extractPrice(message:String)->Double{
        let decimal = message.components(separatedBy: CharacterSet.init(charactersIn: "0123456789.").inverted)
        for item in decimal{
            if let number = Double(item){
                return number
            }
        }
        return 0
    }
}

struct PrivateLessonPurchasingPage_Previews: PreviewProvider {
    static var previews: some View {
        PrivateLessonPurchasingPage(purchaseLink: "https://google.com", lessonName: "50-Session Pack")
    }
}


struct PrivateLessonPriceDisplay:View{
    var subtotal: Double
    var tax: Double
    var total: Double
    var body: some View{
        ZStack{
            CardBackground()
            VStack(alignment:.leading , spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
                PurchaseInfoTitle(title: "课时费用", imageString: "dollarsign.circle")
                Spacer()
                    .frame(height:12.0)
                VStack {
                    subtotalSection
                    Spacer()
                }
                VStack{
                    taxSection
                    Spacer()
                        .frame(height: 6.0)
                    DividerView(width: 0.5)
                    Spacer()
                        .frame(height: 6.0)
                    totalSection
                }
            }
            .padding(.all)
        }
    }
    var subtotalSection: some View{
        HStack(alignment: .center){
            Text("小计")
                .foregroundColor(Color("white"))
            Spacer()
            Text("$"+String(format: "%.2f", subtotal))
                .foregroundColor(Color("white"))
                
            

        }
    }
    var taxSection: some View{
        HStack(alignment: .center){
            Text("HST")
                .foregroundColor(Color("white"))
            Spacer()
            Text("$"+String(format: "%.2f", tax))
                .foregroundColor(Color("white"))


        }.font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
    }
    var totalSection: some View{
        VStack {
            
            HStack(alignment: .center){
                Text("总计")
                    .foregroundColor(Color("white"))
                Spacer()
                Text("$"+String(format: "%.2f", total))
                    .foregroundColor(Color("white"))
                    
                

            }
        }
    }
}
