//
//  ContractPurchasingPage.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-31.
//

import SwiftUI

struct ContractPurchasingPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let clientId: String
    let contractName: String
    let contractInfos: Contract?
    let locationId: Int
    
    @ObservedObject var contractPurchaseManager: ContractPurchaseManager
    
    
    //MARK: promotion code pop up
    @State var showPromoCodeDialog:Bool = false
    @State var enteredPromoCode: String = ""
    @State var emptyPromoWarning: Bool = false
    
    //MARK: Loading state var
    @State var promoCodeLoading:Bool = false
    @State var paymenMethodLoading: Bool = false
    @State var processPurchaseLoading: Bool = false
    
    //MARK: confirm button select payment pop up
    @State var cardShown = false
    @State var cardDismissal = false
    
    
    //MARK: state to check if credit card registration should be displayed
    
    @State var displayCreditCardRegister: Bool = false
    
    //MARK:state to check if debit registration should be displayed
    
    @State var displayDirectDebitResgister: Bool = false
    
    //MARK: agreement chekcbox boolean and full name confirm
    
    @State var isAgreementChecked: Bool = false
    @State var fullNameConfirm: String = ""
    
    @State var newCreditCardInfo:ClientCreditCardInfo = ClientCreditCardInfo(Address: "", CardHolder: "", CardNumber: "", CardType: "", City: "", ExpMonth: "", ExpYear: "", PostalCode: "", State: "")
    @State var isCreditCardMissingField:Bool = false
    
    //
    @State var newDirectDebitInfo:AddClientDirectDebitRequest = AddClientDirectDebitRequest(Test: false, ClientId: "", NameOnAccount: "", RoutingNumber: "", AccountNumber: "", AccountType: "Savings")
    @State var isDirectDebitFieldMissing : Bool = false
    @State var branchNumber:String = ""
    @State var transitNumber:String = ""
    
    
    @State var paymentMethodDisplay:Bool = false
    
    
    //MARK: date display
    @State var startDateDisplay: String?
    @State var dateSelectorCardShown: Bool = false
    @State var dateSelectorDismissal = false
    
    //MARK: keyboard management
    @ObservedObject var avoider = KeyboardAvoider()
    
    var initialSubtotal: Double{
        contractInfos?.firstSubtotal ?? 0.0
    }
    var initalTax: Double{
        let taxRate = contractInfos?.firstTax ?? 0.0
        return initialSubtotal*taxRate
    }
    var initialTotal: Double{
        return initialSubtotal+initalTax
    }
    
    init(contractName:String,contractInfos:Contract?,locationId: Int) {
        self.clientId = "100013341"
        self.contractName = contractName
        self.contractInfos = contractInfos
        self.locationId = locationId
        self.contractPurchaseManager = ContractPurchaseManager(
            locationId: self.locationId,
            clientId: self.clientId,
            contractId: Int(self.contractInfos?.contractId ?? 1),
            serviceid: Int(self.contractInfos?.contractItems[0].serviceItemId ?? "0")!)
    }
    
    
    var body: some View {
        ZStack{
            Color("main_background")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                ScrollView{
                    VStack(spacing:20){
                        PurchaseGeneralInfos(purchaseName: contractName)
                            .padding(.horizontal)
                        
                        PurchaseContractDateDisplay(
                            subtotal: initialSubtotal,
                            tax: initalTax,
                            total: initialTotal,
                            selectedDate: $startDateDisplay,
                            dateSelectorCardShown: $dateSelectorCardShown)
                            .padding(.horizontal)
                        PurchaseContractPricingDisplay(
                            subtotal: initialSubtotal,
                            tax: initalTax,
                            total: contractPurchaseManager.currentTotal ?? initialTotal,
                            discountAmount: contractPurchaseManager.discountedAmount ?? 0,
                            promoCodeDisplay: contractPurchaseManager.promotionCode ?? "",
                            showPromoCodeDialog: $showPromoCodeDialog,
                            promoCodeLoading: $promoCodeLoading)
                            .padding(.horizontal)
                        
                        if paymentMethodDisplay{
                            PurchaseMethodDisplay(
                                storedCardInfo: contractPurchaseManager.creditCardInfo,
                                directDebitInfo: contractPurchaseManager.directDebitInfo,
                                creditCardRegistrationDisplay: $displayCreditCardRegister,
                                directDebitRegistrationDisplay: $displayDirectDebitResgister)
                                .padding(.horizontal)
                        }
                        
                        
                        PurchaseAgreementDisplay(isAgreementChecked: $isAgreementChecked,enteredName:$fullNameConfirm, avoider: avoider)
                            .padding(.horizontal)
                        Spacer()
                            .frame(height: 10.0)
                    }
                }
                .attachKeyboardAvoider(avoider, offset: 0)
                .registerKeyboardAvoider(avoider)
                
                
                bottomConfirmButton
            }
            .ignoresSafeArea(edges:.bottom)
            if showPromoCodeDialog{
                promoCodeDialog
                
            }
            paymentMethodBottomSheet
            dateSelectionBottomSheet
            
            if displayCreditCardRegister{
                createNewCreditCardDialog
            }
            
            if displayDirectDebitResgister{
                createNewDirectDebitDialog
            }
            
            if paymenMethodLoading || processPurchaseLoading{
                LoadingScreen()
            }
            
            
        }

    }
    var promoCodeDialog: some View{
        ModalDialogView(
            showModal: $showPromoCodeDialog,
            cancelText:"cancel",
            confirmText:"confirm",
            content:
                VStack {
                    TextField("enter your promotion code",text: $enteredPromoCode).foregroundColor(Color("main_background"))
                    if emptyPromoWarning{
                        HStack {
                            Text("you did not enter a code yet")
                                .foregroundColor(.red)
                            Spacer()
                        }
                        
                    }
                },
            onConfirm: {
                if enteredPromoCode != ""{
                    withAnimation(.easeOut(duration: 0.1)){
                        showPromoCodeDialog = false
                    }
                    print(enteredPromoCode)
                    contractPurchaseManager.updatePromoCode(with: enteredPromoCode)
                    promoCodeLoading = true
                    contractPurchaseManager.originalTotal = initialTotal
                    contractPurchaseManager.processShoppingCart(
                        onCompetion: {
                            promoCodeLoading = false
                            emptyPromoWarning = false

                        
                        },
                        onFailure: { ifValueGet in
                            if (ifValueGet){
                                contractPurchaseManager.promotionCode = enteredPromoCode
                                promoCodeLoading = false
                                emptyPromoWarning = false

                            }
                            else{
                                print("promo code does not exist")
                                promoCodeLoading = false
                                emptyPromoWarning = false
                                enteredPromoCode = ""


                            }
                            
                            
                        })
                }
                else{
                    showPromoCodeDialog = true
                    emptyPromoWarning = true
                }
            },
            onCancel: {
                enteredPromoCode = ""
                emptyPromoWarning = false
                
            }
        )
        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
            
    }
    var paymentMethodBottomSheet: some View{
        BottomSheetView(cardShown:$cardShown, cardDismissal: $cardDismissal,offset:300, whenExpanded: 0){
            PurchaseContractBottomSheetContent(
                cardShown: $cardShown,
                showDirectDebitPopUp: $displayDirectDebitResgister,
                showCreditCardPopUp: $displayCreditCardRegister,
                paymentMethodDisplay: $paymentMethodDisplay,
                paymentMethodLoading: $paymenMethodLoading,
                contractPurchaseManager: self.contractPurchaseManager
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
    }
    
    var dateSelectionBottomSheet: some View{
        BottomSheetView(cardShown: $dateSelectorCardShown, cardDismissal: $dateSelectorDismissal,offset:UIScreen.main.bounds.height, whenExpanded: 20 ){
            DatePicker(dateSelectorCardShown: $dateSelectorCardShown){
                selectedDate in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy MMMM dd"
                startDateDisplay = formatter.string(from: selectedDate)
                
                let requestFormatter = DateFormatter()
                requestFormatter.dateFormat = "yyyy-MM-dd"
                let selectedDateInString = requestFormatter.string(from: selectedDate)
                contractPurchaseManager.updateStartDate(with: selectedDateInString)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
    }
    
    var bottomConfirmButton: some View{
        Button(action: {
            if paymentMethodDisplay{
                contractPurchaseManager.setContractRequestOffical()
                withAnimation{
                    processPurchaseLoading = true
                }
                contractPurchaseManager.postContractPurchase(
                    If_Succeeded: {
                        print("purchase successful")
                        withAnimation{
                            processPurchaseLoading.toggle()
                        }
                        presentationMode.wrappedValue.dismiss()
                    },
                    If_Failed: {
                        print("\nPurchase not successful")
                        withAnimation{
                            processPurchaseLoading.toggle()
                        }
                    })
            }
            else{
            if isAgreementChecked /*&& (fullNameConfirm != "")*/{ // add this late
                withAnimation{
                    cardShown.toggle()
                }
            }
            }
        }, label: {
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
    
    var createNewCreditCardDialog: some View{
        ModalDialogView(
            showModal: $displayCreditCardRegister,
            cancelText: "取消",
            confirmText: "确认",
            content:
                createCreditCardContent,
            onConfirm: {
                if checkCreditCardMissingField(){
                    withAnimation() {
                        
                        isCreditCardMissingField.toggle()
                    }
                }
                else{
                    withAnimation(){
                        paymenMethodLoading = true
                        displayCreditCardRegister.toggle()
                    }
                    contractPurchaseManager.updateClientCreditCardInfo(
                        newCreditCardInfo: newCreditCardInfo,
                        If_Succeeded: {
                            // set the card to be used to credit card
                            contractPurchaseManager.contractPurchaseRequest.setStoredCard(
                                lastFour: newCreditCardInfo.LastFour)
                            print(contractPurchaseManager.creditCardInfo!)
                            if !paymentMethodDisplay{
                                withAnimation(){
                                    paymenMethodLoading.toggle()
                                    paymentMethodDisplay = true
                                }
                            }
                            else{
                                
                                
                            }
                            
                            
                        },
                        If_Error: {
                            // alert the user that it didnt work
                            print("adding new credit card info failed for some reason")
                        }
                    )
                }
                
                
            },
            onCancel: {
                isCreditCardMissingField = false
                
            }
        )
        .zIndex(1.0)
    }
    
    var createNewDirectDebitDialog: some View{
        ModalDialogView(
            showModal: $displayDirectDebitResgister,
            cancelText: "取消",
            confirmText: "确认",
            content:
                createDirectDebitContent,
            onConfirm: {
                newDirectDebitInfo.RoutingNumber = branchNumber + transitNumber
                newDirectDebitInfo.ClientId = self.clientId
                if checkDirectDebitMissingField(){
                    withAnimation() {
                        isDirectDebitFieldMissing.toggle()
                    }
                }
                else{
                    paymenMethodLoading = true
                    
                    contractPurchaseManager.addClientDirectDebitInfo(
                        newDirectDebitInfo: newDirectDebitInfo,
                        If_Succeeded: {
                            //set the request to use direct debit
                            contractPurchaseManager.contractPurchaseRequest.setDirectDebit()
                            
                            
                            print(contractPurchaseManager.directDebitInfo!)
                            if !paymentMethodDisplay{
                                withAnimation(){
                                    paymentMethodDisplay = true
                                    paymenMethodLoading.toggle()
                                }
                                withAnimation(){
                                    displayDirectDebitResgister.toggle()
                                }
                            }
                            else{
                                
                            }
                            
                            
                        },
                        If_Error: {
                            
                            // alert the user that it didnt work
                        }
                    )
                }
                
                
            },
            onCancel: {
                isDirectDebitFieldMissing = false
                
            }
        )
        .zIndex(1.0)
    }
    var createCreditCardContent: some View{
        VStack{
            TextField("Card Number",text: $newCreditCardInfo.CardNumber)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
            
            HStack {
                TextField("Year",text: $newCreditCardInfo.ExpYear)
                    .padding(.bottom)
                    .foregroundColor(Color("main_background"))
                TextField("Month",text: $newCreditCardInfo.ExpMonth)
                    .padding(.bottom)
                    .foregroundColor(Color("main_background"))
            }
            
            TextField("Full Name",text: $newCreditCardInfo.CardHolder)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
           
            
           
            TextField("Billing Address",text: $newCreditCardInfo.Address)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
            TextField("Card Type",text: $newCreditCardInfo.CardType)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
            HStack {
                TextField("City",text: $newCreditCardInfo.City)
                    .padding(.bottom)
                    .foregroundColor(Color("main_background"))
                TextField("Province" ,text: $newCreditCardInfo.State)
                    .foregroundColor(Color("main_background"))
                    .padding(.bottom)
            }
            TextField("Postal Code",text: $newCreditCardInfo.PostalCode)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
                .padding(.bottom)
            
            if isCreditCardMissingField{
                
                Text("you did not enter all fields")
                    .foregroundColor(.red)
            }
            
            
        }
    }
     
    var createDirectDebitContent: some View{
        VStack{
            RadioGroup(
                buttonNames: ["Savings","Checking"],
                selectedButton: $newDirectDebitInfo.AccountType)
                .padding(.bottom)
            
            TextField("Branch Number",text: $branchNumber)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
            
            
            
            TextField("Transit Name",text: $transitNumber)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
           
            TextField("Account Address",text: $newDirectDebitInfo.AccountNumber)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
            
            TextField("Card Type",text: $newDirectDebitInfo.NameOnAccount)
                .padding(.bottom)
                .foregroundColor(Color("main_background"))
            
            
            
            if isDirectDebitFieldMissing{
                
                Text("you did not enter all fields")
                    .foregroundColor(.red)
            }
            
        }
    }
    
    func checkCreditCardMissingField()->Bool{
        let mirror = Mirror(reflecting:newCreditCardInfo)
        
        for child in mirror.children{
            let enteredValue = child.value
            print(enteredValue)
            if enteredValue as! String == ""{
                
                return true
            }
        }
        return false
    }
    
    func checkDirectDebitMissingField()->Bool{
        let mirror = Mirror(reflecting:newDirectDebitInfo)
        print(newDirectDebitInfo)
        for child in mirror.children{
            let enteredValue = child.value
            let key = child.label
            print(enteredValue)
            if key == "Test"{
                print(key as Any)
                continue
            }
            else if enteredValue as! String == ""{
                print(key as Any)
                print(enteredValue)

                return true
            }
        }
        return false
    }
   
}

struct PurchaseContractDateDisplay: View{
    var subtotal: Double
    var tax: Double
    var total: Double
    @Binding var selectedDate:String?
    @Binding var dateSelectorCardShown:Bool
    
    var body: some View{
        ZStack{
            CardBackground()
            VStack(alignment:.leading,spacing:nil){
                PurchaseInfoTitle(title: "课时费用", imageString: "dollarsign.circle")
                Spacer()
                    .frame(height:12.0)
                VStack {
                    dateSelectionSection
                    Spacer()
                }
                
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
    var dateSelectionSection: some View{
        HStack(alignment: .center){
            Text("Start Date")
                .foregroundColor(Color("white"))
            Spacer()
            if selectedDate != nil{
                Text(selectedDate!)
                    .foregroundColor(Color("white"))
            }
            Image(systemName: "plus.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(Color("yellow"))
                .onTapGesture {
                    withAnimation(){
                        dateSelectorCardShown = true
                    }
                }
            
                
            

        }
    }
    
    var subtotalSection: some View{
        HStack(alignment: .center){
            Text("小计")
                .foregroundColor(Color("white"))
            Spacer()
            Text(String(format: "%.2f", subtotal))
                .foregroundColor(Color("white"))
                
            

        }
    }
    
    var taxSection: some View{
        HStack(alignment: .center){
            Text("HST")
                .foregroundColor(Color("white"))
            Spacer()
            Text(String(format: "%.2f", tax))
                .foregroundColor(Color("white"))


        }.font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
    }
    var totalSection: some View{
        VStack {
            HStack(alignment: .center){
                Text("总计")
                    .foregroundColor(Color("white"))
                Spacer()
                Text(String(format: "%.2f", total))
                    .foregroundColor(Color("white"))
                    
                

            }
        }
    }
}

struct PurchaseContractPricingDisplay: View{
    var subtotal: Double
    var tax: Double
    var total: Double
    var discountAmount: Double
    var promoCodeDisplay:String
    @Binding var showPromoCodeDialog:Bool
    @Binding var promoCodeLoading:Bool
    

    var body: some View{
        ZStack{
            CardBackground()
            VStack(alignment:.leading,spacing:nil){
                PurchaseInfoTitle(title: "课时费用", imageString: "dollarsign.circle")
                Spacer()
                    .frame(height:12.0)
                
                VStack {
                    promoCodeSection
                    Spacer()
                    
                }
                
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
    var promoCodeSection: some View{
        HStack(alignment: .center){
            Text("Promo Code:")
                .foregroundColor(Color("white"))
            Spacer()
            if promoCodeLoading{
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
            }
            if promoCodeDisplay=="" {
                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color("yellow"))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)){
                            showPromoCodeDialog.toggle()
                        }
                    }
            }
            else{
                Text(promoCodeDisplay)
                    .foregroundColor(Color("gray"))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)){
                            showPromoCodeDialog.toggle()
                        }
                    }
            }
            
        }
    }
    
    
    var subtotalSection: some View{
        HStack(alignment: .center){
            Text("小计")
                .foregroundColor(Color("white"))
            Spacer()
            Text(String(format: "%.2f", subtotal))
                .foregroundColor(Color("white"))
                
            

        }
    }
    var taxSection: some View{
        HStack(alignment: .center){
            Text("HST")
                .foregroundColor(Color("white"))
            Spacer()
            Text(String(format: "%.2f", tax))
                .foregroundColor(Color("white"))


        }.font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
    }
    var totalSection: some View{
        VStack {
            if discountAmount != 0{
                HStack(alignment: .center){
                    
                    Spacer()
                    Text("-")
                        .foregroundColor(Color("white"))
                    Text(String(format: "%.2f", discountAmount))
                        .foregroundColor(Color("white"))
                        
                    

                }
            }
            HStack(alignment: .center){
                Text("总计")
                    .foregroundColor(Color("white"))
                Spacer()
                Text(String(format: "%.2f", total))
                    .foregroundColor(Color("white"))
                    
                

            }
        }
    }
    
     
}

struct PurchaseContractBottomSheetContent: View{
    @Binding var cardShown: Bool
    @Binding var showDirectDebitPopUp: Bool
    @Binding var showCreditCardPopUp: Bool
    @Binding var paymentMethodDisplay: Bool
    @Binding var paymentMethodLoading: Bool
    @ObservedObject var contractPurchaseManager:ContractPurchaseManager
    var body: some View{
        VStack{
            directDebitButton
            Spacer().frame(height:0)
            
            creditCardButton
            DividerView(width: 4)
            
            cancelButton
        }
        
    }
    
    var directDebitButton: some View{
        Button(action: {
            
            withAnimation(){
                cardShown.toggle()
                paymentMethodLoading.toggle()
            }
            
            contractPurchaseManager
                .extractClientDirectDebitInfo
            {
                withAnimation{
                    paymentMethodLoading.toggle()
                    paymentMethodDisplay.toggle()
                    
                }
                contractPurchaseManager.contractPurchaseRequest.setDirectDebit()
                print("\(String(describing: contractPurchaseManager.directDebitInfo))" )
            } if_user_has_no_debit: {
                print("this guy doesn't have a direct debit")
                withAnimation(){
                    paymentMethodLoading.toggle()
                    showDirectDebitPopUp.toggle()
                }
            }

        }, label: {
            HStack {
                Spacer()
                Text("借记卡支付")
                    .foregroundColor(Color("main_background"))
                Spacer()
            }
            .padding(.vertical)
        })
    }
    
    var creditCardButton: some View{
        Button(action: {
            
            withAnimation(){
                cardShown.toggle()
                paymentMethodLoading.toggle()
            }
            contractPurchaseManager.extractClientCreditCardInfo(
                if_user_has_one: {
                    withAnimation{
                        paymentMethodLoading.toggle()
                        paymentMethodDisplay.toggle()
                    }
                    contractPurchaseManager.contractPurchaseRequest.setStoredCard(
                        lastFour: contractPurchaseManager.creditCardInfo!.LastFour)
                    
                    print("\(String(describing: contractPurchaseManager.creditCardInfo))" )
                },
                if_Null: {
                    print("this guy doesn't have a credit card")
                    withAnimation(){
                        paymentMethodLoading.toggle()
                        showCreditCardPopUp.toggle()
                    }
                }
            )
        }, label: {
            HStack {
                Spacer()
                Text("信用卡支付")
                    .foregroundColor(Color("main_background"))
                Spacer()
            }
            .padding(.vertical)
        })
    }
    
    var cancelButton: some View{
        Button(action: {
            
            withAnimation(){
                cardShown.toggle()
            }
        }, label: {
            HStack {
                Spacer()
                Text("取消")
                    .foregroundColor(Color("main_background"))
                Spacer()
            }
            .padding(.vertical)
        })
    }
}


struct ContractPurchasingPage_Previews: PreviewProvider {
    static var previews: some View {
        ContractPurchasingPage(contractName: "Contract Name", contractInfos: /*Contract(contractId: 347, contractName: "", agreementTerms: "", firstSubtotal: 1, firstTax: 2, firstTotal: 3, recurringSubtotal: 1, recurringTax: 2, recurringTotal: 3, contractItems: [ContractItems(serviceItemId:"1")]),
                                locationId: 1)*/nil, locationId: 1)
            
    }
}


