//
//  PurchaseTabsView.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-04.
//

import SwiftUI

struct PurchaseTabsView: View {
    @State var index = 1 // reminder: make the loading at this level
    @State var offset : CGFloat = 0
    @State var loading: Bool = false
    var servicePurchaseViewModel = ServicePurchaseViewModel()
    var contractPurchaseViewModel = ContractPurchaseViewModel(locationId: 1)
    // putting(storing) a view as variable allow the view to be only initialized once
    // the following view needs network request in initialized therefore must be initialized here
    var paymentHistoryPurchasePage = PaymentPurchaseHistoryPage(clientId: "100013341")
    var body: some View {
        
//        NavigationView {
            ZStack {
                Color("main_background")
//                    .ignoresSafeArea()
//                ScrollView{
                    
                    VStack {
                        PurchaseTabBars(index:self.$index, offset: self.$offset)
                        GeometryReader{
                            g in
                            HStack(spacing:0){
                                
                                // this is where u put the main views under the tab bar
                                GroupClassPurchasePreview(
                                    servicePurchaseViewModel: servicePurchaseViewModel,
                                    contractPurchaseViewModel: contractPurchaseViewModel )
                                    .frame(width: g.frame(in: .global).width)
                                PrivateLessonPurchasePreview()
                                    .frame(width: g.frame(in: .global).width)
//                                paymentHistoryPurchasePage
//                                    .frame(width: g.frame(in: .global).width)
                            }
                            .offset(x: self.offset)
                        }
                        Text("")
                        
                    }
                    .animation(.default)
                    .background(Color("black"))
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .statusBar(hidden: false)
                    .navigationBarBackButtonHidden(true)
                
//                }
            }
//        }
//        .navigationBarHidden(true)
//        .navigationBarTitleDisplayMode(.inline)
            
    }
}

struct PurchaseTabsView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseTabsView()
    }
}

struct PurchaseTabBars: View {
    @Binding var index: Int
    @Binding var offset : CGFloat
    var tabsCount = 2 // change back to 2
    var width = UIScreen.main.bounds.width
    var body: some View{
        
        VStack (spacing:0){
            HStack{
                Spacer()
                Button(action: {
                    self.index = 1
                    self.offset = 0
                    
                }){
                    VStack{
                        Text("团课")
                            .font(.title2)
                            .foregroundColor(self.index == 1 ? Color("white") : Color("gray"))
                        
    
                    }.fixedSize()
                }
                Spacer()
                    .frame(width:self.width/2.5)// change back to width/2.5
                Button(action: {
                    self.index = 2
                    self.offset = -self.width
                }){
                    VStack{
                        Text("私教")
                            .foregroundColor(self.index == 2 ? Color("white") : Color("gray"))
                            .font(.title2)
                        
    
                    }.fixedSize()
                }
                //when changed back delete the modified spacer and add
                Spacer()
//                Spacer()
//                    .frame(width:self.width/4)
                
                // delete this button when done with the purchase history
                
            }
            GeometryReader{ g in
                Capsule()
                    .fill(Color("yellow"))
                    .frame(width: self.tabWidth(from: g.size.width), height: 4, alignment: .center)
                    .offset(x: self.selectionBarXOffset(from: g.size.width), y: 0)
                
                
            }
            
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        }
    }
    private func selectionBarXOffset(from totalWidth: CGFloat)->CGFloat{
        return self.tabWidth(from: totalWidth) * CGFloat(index-1)
    }
    private func tabWidth(from totalWidth: CGFloat)-> CGFloat{
        return totalWidth/CGFloat(tabsCount)
    }
}
