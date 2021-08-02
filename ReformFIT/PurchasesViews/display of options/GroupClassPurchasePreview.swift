//
//  ContentView.swift
//  Shared
//
//  Created by Chen Chen on 2021-07-20.
//

import SwiftUI


struct GroupClassPurchasePreview: View {
    @ObservedObject var servicePurchaseViewModel:ServicePurchaseViewModel
    @ObservedObject var contractPurchaseViewModel:ContractPurchaseViewModel
    @State private var serviceInfoLoaded = false
    @State private var contractInfoLoaded = false

    var topImage: some View {
        Image(systemName: "sparkle")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100.0)
    }
    
    var body: some View {
         
        NavigationView {
            ZStack(){
                Color("black2")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                
                ScrollView {
                    ZStack {
                        
                        VStack(spacing:20){
                            topImage
                                
                                
                            
                            MembershipPurchaseOptions(contractInfoLoaded: $contractInfoLoaded,contractPurchaseViewModel: contractPurchaseViewModel)
                                .padding(.horizontal)
                            PassPurchaseOptions(serviceInfoLoaded: $serviceInfoLoaded,servicePurchaseViewModel: servicePurchaseViewModel)
                                .padding(.horizontal)
                            
                            
                            
                                
                        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                if servicePurchaseViewModel.loading{
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                }
                if contractPurchaseViewModel.loading{
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                }
                
                
            }
        }.navigationBarHidden(true)
    }
}







struct GroupClassPurchasePreview_Previews: PreviewProvider {
    static var previews: some View {

        GroupClassPurchasePreview(servicePurchaseViewModel: ServicePurchaseViewModel(),contractPurchaseViewModel: ContractPurchaseViewModel(locationId: 1))
    }
}

struct PurchaseTypeTitleView: View{
    
    var title :String
    var imageString : String
    
    var body: some View{
        
        HStack(alignment: .center) {
            Image(systemName: imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30.0, height: 30.0)
                
            Text(title)
                .font(.title)
            
        }
        .foregroundColor(.yellow)
    }
    
    
    
}
struct PurchaseInfo: View {
    
    var info: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "info.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(Color("grey"))
            Text(info)
                .foregroundColor(Color("grey"))
            
        }
    }
}


struct OnePurchaseOption: View {
    let purchaseOption:PurchaseOption
    
    var titleDisplay: some View {
        Text(purchaseOption.nameOfPurchase)
            .font(.title2)
            .foregroundColor(Color("white"))
        
    }
    var infosDislay: some View {
        ForEach(purchaseOption.purchaseInfos,id:\.self){ info in
            PurchaseInfo(info: info)
        }
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                titleDisplay
                
                infosDislay
                
                
                
            }
            Spacer()
            PricingDisplay(price:purchaseOption.price)
            
        }
        
    }
}

struct PricingDisplay: View {
    
    var price:String
    var body: some View {
        HStack(alignment: .center) {
            Text(price)
                .foregroundColor(Color("white"))
            Image(systemName: "arrowtriangle.forward")
                .foregroundColor(.yellow)
        }
    }
}

struct MembershipPurchaseOptions: View {
    @Binding var contractInfoLoaded: Bool
    @State var chosenOptionName: String?
    var contractPurchaseViewModel: ContractPurchaseViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(Color("black3"))
            VStack(alignment: .leading){
                
                PurchaseTypeTitleView(title: "Premier Burn", imageString: "list.bullet")
                
                DividerView()
                    .foregroundColor(.blue)
                    .padding(.vertical)
                
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["Premier BURN!"]!)
                    .contentShape(Rectangle())
                    .onTapGesture (perform:{
                        dataFetching(optionName: "Premier BURN!")
                        
                    })
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["Elite BURN!"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        dataFetching(optionName: "Elite BURN!")


                })
                
                    
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions ["Master BURN!"]!)
                    .contentShape(Rectangle())
                    .padding(.top)
                    .onTapGesture (perform:{
                        dataFetching(optionName: "Master BURN!")

                    })
                NavigationLink(
                    destination: ContractPurchasingPage(contractName: chosenOptionName ?? "", contractInfos:contractPurchaseViewModel.obtainedContract ?? nil),
                    isActive: self.$contractInfoLoaded,
                    label: {
                        

                        EmptyView()
                            
                    })
            }
            .padding(.all)
            .layoutPriority(1)
            
            
        }
    }
}


extension MembershipPurchaseOptions{
    func dataFetching(optionName option:String)->Void{
        contractPurchaseViewModel.loadContract(contractId:PurchaseData.purchaseOptions[option]!.contractId!) {
            chosenOptionName = option
            print("id: \(contractPurchaseViewModel.obtainedContract!.contractId)")
            print("price: \(contractPurchaseViewModel.obtainedContract!.firstSubtotal)")
            print("tax: \(contractPurchaseViewModel.obtainedContract!.firstTax)")
            if !contractPurchaseViewModel.loading{
                contractInfoLoaded = true
            }
        }
    }
}

struct PassPurchaseOptions: View {
    @Binding var serviceInfoLoaded:Bool
    var servicePurchaseViewModel:ServicePurchaseViewModel
    @State var chosenOptionName : String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(Color("black3"))
            VStack(alignment: .leading){
                PurchaseTypeTitleView(title: "Pass Member", imageString: "list.bullet")
                
                DividerView()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.vertical)
                
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["20-Class Pass"]!)
                    .contentShape(Rectangle())
                    .onTapGesture (perform:{
                        dataFetching(optionName: "20-Class Pass")
                        
                    })
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["10-Class Pass"]!)
                    .contentShape(Rectangle())
                    .onTapGesture (perform:{
                        dataFetching(optionName: "10-Class Pass")
                        
                    })
                    .padding(.top)
                
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["1-Month Pass"]!)
                    .contentShape(Rectangle())
                    .onTapGesture (perform:{
                        dataFetching(optionName: "1-Month Pass")
                        
                    })
                    .padding(.top)
                OnePurchaseOption(purchaseOption: PurchaseData.purchaseOptions["Single Pass"]!)
                    .contentShape(Rectangle())
                    .onTapGesture (perform:{
                        dataFetching(optionName: "Single Pass")
                        
                    })
                    .padding(.top)
                
                NavigationLink(
                    destination: PassPurchasingPage(serviceName: chosenOptionName ?? "", serviceInfos:servicePurchaseViewModel.obtainedService ?? nil),
                    isActive: self.$serviceInfoLoaded,
                    label: {
                        

                        EmptyView()
                            
                    })
            }
            .padding(.all)
            
            
        }
    }
}

extension PassPurchaseOptions{
    
    
    func dataFetching( optionName option:String){
        servicePurchaseViewModel.LoadService(serviceId: PurchaseData.purchaseOptions[option]!.serviceId!){
            chosenOptionName = option
            print("id: \(servicePurchaseViewModel.obtainedService!.Id)")
            print("price: \(servicePurchaseViewModel.obtainedService!.Price)")
            print("tax: \(servicePurchaseViewModel.obtainedService!.TaxRate)")
            if !servicePurchaseViewModel.loading{
                print("loaded")
                serviceInfoLoaded = true
            }
            
        }
        
    }
}



