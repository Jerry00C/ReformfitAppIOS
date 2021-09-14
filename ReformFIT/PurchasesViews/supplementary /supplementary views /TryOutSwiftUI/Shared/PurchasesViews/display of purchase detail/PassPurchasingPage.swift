//
//  PassPurchasingPage.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-07-31.
//

import SwiftUI
import Combine

struct PassPurchasingPage: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let clientId:String
    let serviceName:String
    let serviceInfos:Service?
    @ObservedObject var shoppingCartManager:ShoppingCartManager
    
    //MARK: gift card pop up
    @State var showGiftCardDialog:Bool = false
    @State var enteredGiftCard: String = ""
    @State var emptyGiftCardWarning: Bool = false
    
   
    //MARK: promotion code pop up
    @State var showPromoCodeDialog:Bool = false
    @State var enteredPromoCode: String = ""
    @State var emptyPromoWarning: Bool = false
    
    //MARK: Loading state var
    @State var promoCodeLoading:Bool = false
    @State var giftCardLoading:Bool = false
    @State var paymenMethodLoading: Bool = false
    @State var processPurchaseLoading: Bool = false
    
    //MARK: keyboard management
    @ObservedObject var avoider = KeyboardAvoider()
    @State private var keyboardHeight:CGFloat = 0
    @State var scale: CGFloat = 1
    
    //MARK: confirm button select payment pop up
    @State var cardShown = false
    @State var cardDismissal = false
    
    //MARK: agreement chekcbox boolean and full name confirm
    
    @State var isAgreementChecked: Bool = false
    @State var fullNameConfirm: String = ""
    
    //MARK: state to check if credit card registration should be displayed
    
    @State var displayCreditCardRegister: Bool = false
    
    //MARK:state to check if debit registration should be displayed
    
    @State var displayDirectDebitResgister: Bool = false
    
    //MARK: credit card Info state to be entered
    
    @State var newCreditCardInfo:ClientCreditCardInfo = ClientCreditCardInfo(Address: "", CardHolder: "", CardNumber: "", CardType: "", City: "", ExpMonth: "", ExpYear: "", PostalCode: "", State: "")
    @State var isCreditCardMissingField:Bool = false
    
    //
    @State var newDirectDebitInfo:AddClientDirectDebitRequest = AddClientDirectDebitRequest(Test: false, ClientId: "", NameOnAccount: "", RoutingNumber: "", AccountNumber: "", AccountType: "Savings")
    @State var isDirectDebitFieldMissing : Bool = false
    @State var branchNumber:String = ""
    @State var transitNumber:String = ""
    
    
    @State var paymentMethodDisplay:Bool = false
    
    var initialSubtotal: Double{
        serviceInfos?.Price ?? 0.0
    }
    var initalTax: Double{
        let taxRate = serviceInfos?.TaxRate ?? 0.0
        return initialSubtotal*taxRate
    }
    var initialTotal: Double{
        return initialSubtotal+initalTax
    }
    
    
    init(serviceName:String,serviceInfos:Service?) {
        self.clientId = "100013341"
        self.serviceName = serviceName
        self.serviceInfos = serviceInfos
        self.shoppingCartManager = ShoppingCartManager(
            clientId: self.clientId,
            serviceId: Int(self.serviceInfos?.Id ?? "0")!
        )
        let compMethod = SCartComp(Amount: 0)
        self.shoppingCartManager.addPayment(amount: Payment.comp(compMethod))
        self.shoppingCartManager.processShoppingCart(onCompetion: {}, onFailure: {[self] ifGetValue in
            if ifGetValue{
                shoppingCartManager.originalTotal = shoppingCartManager.currentTotal
            }
        })
        self.newDirectDebitInfo.ClientId = self.clientId// does not work for some reason
        print(self.shoppingCartManager.originalTotal ?? 0)
    
    
    }
    var body: some View {
        ZStack{
            Color("main_background")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                ScrollView{
                    VStack(spacing: 20){
                        PurchaseGeneralInfos(purchaseName: serviceName)
                            .padding(.horizontal)
                        PurchasePricingDisplay(
                            subtotal: initialSubtotal,
                            tax: initalTax,
                            total: shoppingCartManager.currentTotal ?? initialTotal,
                            discountAmount: shoppingCartManager.discountedAmount ?? 0,
                            promoCodeDisplay: shoppingCartManager.promotionCode ?? "",
                            showPromoCodeDialog: $showPromoCodeDialog,
                            promoCodeLoading: $promoCodeLoading,
                            giftCardDisplay: shoppingCartManager.giftCardNumber ?? "",
                            showGiftCardDialog: $showGiftCardDialog,
                            giftCardLoading: $giftCardLoading
                        )
                            .padding(.horizontal)
                        
                        if paymentMethodDisplay{
                            PurchaseMethodDisplay(
                                storedCardInfo: shoppingCartManager.creditCardInfo,
                                directDebitInfo: shoppingCartManager.directDebitInfo,
                                creditCardRegistrationDisplay: $displayCreditCardRegister,
                                directDebitRegistrationDisplay: $displayDirectDebitResgister
                            )
                                .padding(.horizontal)
                            .onAppear(){
                                print("card info\(String(describing: shoppingCartManager.creditCardInfo))")
                            }
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
            
            //MARK: TO SHOW PROMOTION CODE DIALOG
            if showPromoCodeDialog{
                promoCodeDialog
                
            }
            
            
            if showGiftCardDialog{
                giftCardDialog
                
            }
            paymentMethodBottomSheet
            
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
        .navigationBarTitleDisplayMode(.inline)

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
                    shoppingCartManager.updatePromoCode(with: enteredPromoCode)
                    promoCodeLoading = true
                    shoppingCartManager.processShoppingCart(
                        onCompetion: {
                            promoCodeLoading = false
                            emptyPromoWarning = false

                        
                        },
                        onFailure: { ifValueGet in
                            if (ifValueGet){
                                shoppingCartManager.promotionCode = enteredPromoCode
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
        
    var giftCardDialog: some View{
        ModalDialogView(
            showModal: $showGiftCardDialog,
            cancelText:"cancel",
            confirmText:"confirm",
            content:
                VStack {
                    TextField("enter your gift card barcode id",text: $enteredGiftCard).foregroundColor(Color("main_background"))
                    if emptyGiftCardWarning{
                        HStack {
                            Text("you did not enter a code yet")
                                .foregroundColor(.red)
                            Spacer()
                        }
                        
                    }
                },
            onConfirm: {
                if enteredGiftCard != ""{
                    withAnimation(.easeOut(duration: 0.1)){
                        showGiftCardDialog = false
                    }
                    print(enteredGiftCard)
                    
                    giftCardLoading = true
                    shoppingCartManager.getGiftCardBalance(barcodeId: enteredGiftCard,
                        onResponse: {
                            giftCardLoading = false
                            emptyGiftCardWarning = false

                        
                        },
                        onErrorResponse: { ifValueGet in
                            if (ifValueGet){
                                shoppingCartManager.giftCardNumber = enteredGiftCard
                                giftCardLoading = false
                                emptyGiftCardWarning = false

                            }
                            else{
                                print("gift card does not exist")
                                giftCardLoading = false
                                emptyGiftCardWarning = false
                                enteredGiftCard = ""


                            }
                            
                            
                        })
                }
                else{
                    showGiftCardDialog = true
                    emptyGiftCardWarning = true
                }
            },
            onCancel: {
                enteredGiftCard = ""
                emptyGiftCardWarning = false
                
            }
        )
        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
    }
    
    var bottomConfirmButton: some View{
        Button(action: {
            if paymentMethodDisplay{
                if shoppingCartManager.currentTotal != 0{// if 0 amount left for user to pay with cc or dd, then proceed to set up cart without them
                    if shoppingCartManager.creditCardInfo != nil{
                        let storedCardInfo = SCartStoredCard(
                            Amount: shoppingCartManager.currentTotal!,
                            LastFour: shoppingCartManager.creditCardInfo!.LastFour)
                        print("credit card last four: \(shoppingCartManager.creditCardInfo!.LastFour)")
                        let storedCardPayment = Payment.storedCard(storedCardInfo)
                        shoppingCartManager.addPayment(amount: storedCardPayment)
                    }
                    else if shoppingCartManager.directDebitInfo != nil{
                        let storedDirectDebitInfo = SCartDirectDebit(Amount: shoppingCartManager.currentTotal!)
                        let directDebitPayment = Payment.directDebit(storedDirectDebitInfo)
                        shoppingCartManager.addPayment(amount: directDebitPayment)
                    }
                }
                else{
                    
                }
                shoppingCartManager.setCartToOfficial()
                print(shoppingCartManager.shoppingCartRequest)
                withAnimation{
                    processPurchaseLoading.toggle()
                }
                shoppingCartManager.processShoppingCart(
                    onCompetion: {
                        print("purchase successful")
                        withAnimation{
                            processPurchaseLoading.toggle()
                        }
                        presentationMode.wrappedValue.dismiss()

                    },
                    onFailure: {TotalGet in
                        withAnimation{
                            processPurchaseLoading.toggle()
                        }
                        if !TotalGet{
                            print("some error other than calculation error has occured")
//                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        else {
                            print("inaccurate price")
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
                        displayCreditCardRegister.toggle()
                    }
                    shoppingCartManager.updateClientCreditCardInfo(
                        newCreditCardInfo: newCreditCardInfo,
                        If_Succeeded: {
                            
                            print(shoppingCartManager.creditCardInfo!)
                            if !paymentMethodDisplay{
                                withAnimation(){
                                    paymentMethodDisplay = true
                                }
                            }
                            else{
                                // alert the user that it didnt work
                            }
                            
                            
                        },
                        If_Error: {}
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
                    
                    
                    shoppingCartManager.addClientDirectDebitInfo(
                        newDirectDebitInfo: newDirectDebitInfo,
                        If_Succeeded: {
                            
                            print(shoppingCartManager.directDebitInfo!)
                            if !paymentMethodDisplay{
                                withAnimation(){
                                    paymentMethodDisplay = true
                                }
                                withAnimation(){
                                    displayDirectDebitResgister.toggle()
                                }
                            }
                            else{
                                // alert the user that it didnt work
                            }
                            
                            
                        },
                        If_Error: {}
                    )
                }
                
                
            },
            onCancel: {
                isDirectDebitFieldMissing = false
                
            }
        )
        .zIndex(1.0)
    }
    
    var paymentMethodBottomSheet: some View{
        BottomSheetView(cardShown:$cardShown, cardDismissal: $cardDismissal,offset:300, whenExpanded: 0){
            PurchaseBottomSheetContent(
                cardShown: $cardShown,
                showDirectDebitPopUp: $displayDirectDebitResgister,
                showCreditCardPopUp: $displayCreditCardRegister,
                paymentMethodDisplay: $paymentMethodDisplay,
                paymentMethodLoading: $paymenMethodLoading,
                shoppingCartManager: self.shoppingCartManager
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
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

struct PassPurchasingPage_Previews: PreviewProvider {
    static var previews: some View {
        PassPurchasingPage(serviceName: "Premier BURN!", serviceInfos: nil)
    }
}

struct PaymentMethodDisplayTitle: View{
    var title :String
    var imageString: String
    @Binding var displayBool: Bool
    
    var body: some View{
        HStack(alignment:.center){
            Text(title)
                .font(.title2)
            Spacer()
            Button(action: {
                
                withAnimation{
                    displayBool = true
                }
            }){
                Image(systemName: imageString)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30.0)
            }
        }
        .foregroundColor(Color("yellow"))
    }
}

struct PurchaseInfoTitle: View{
    
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
        .foregroundColor(Color("yellow"))
    }
    
    
    
}

struct PurchaseInfoDisplay: View {
    
    var info: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "info.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(Color("white"))
            Text(info)
                .foregroundColor(Color("white"))
            
            Spacer()
            Image(systemName: "checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(Color("white"))
            
        }
    }
}

struct PurchaseGeneralInfos: View {
    let purchaseName:String
    var body: some View {
        ZStack{
            CardBackground()
            VStack(alignment:.leading,spacing:nil){
                PurchaseInfoTitle(title: purchaseName, imageString: "list.bullet")
                ForEach(PurchaseData.purchaseOptions[purchaseName]!.purchaseInfos,id:\.self){info in
                    PurchaseInfoDisplay(info: info)
                    
                }
                
            }
            .padding(.all)
            
        }
    }
}

struct PurchasePricingDisplay: View{
    var subtotal: Double
    var tax: Double
    var total: Double
    var discountAmount: Double
    var promoCodeDisplay:String
    @Binding var showPromoCodeDialog:Bool
    @Binding var promoCodeLoading:Bool
    
    var giftCardDisplay:String
    @Binding var showGiftCardDialog:Bool
    @Binding var giftCardLoading:Bool

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
                VStack{
                    giftCardSection
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
    var giftCardSection: some View{
        HStack(alignment: .center){
            Text("Gift Card:")
                .foregroundColor(Color("white"))
            Spacer()
            if giftCardLoading{
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
            }
            if giftCardDisplay == ""{
                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color("yellow"))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)){
                            showGiftCardDialog.toggle()
                        }
                    }
                
            }
            else{
                Text(giftCardDisplay)
                    .foregroundColor(Color("gray"))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)){
                            showGiftCardDialog.toggle()
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

struct PurchaseMethodDisplay: View{
    var storedCardInfo:ClientCreditCardInfo?
    var directDebitInfo:SuccessfulDirectDebitResponse?
    @Binding var creditCardRegistrationDisplay:Bool
    @Binding var directDebitRegistrationDisplay:Bool
    
    var body:some View{
        
        if storedCardInfo != nil{
            ZStack{
                CardBackground()
                VStack(alignment:.leading){
                    PaymentMethodDisplayTitle(title: "付款方式", imageString: "pencil.circle",displayBool: $creditCardRegistrationDisplay)
                    DividerView(width: 1)
                    VStack {
                        Spacer()
                            .frame(height: 6.0)
                        cardNumber
                        
                    }
                    VStack {
                        Spacer()
                            .frame(height: 6.0)
                        cardExpDate
                    }
                }
                .padding(.all)
            }
        }
        
        else if directDebitInfo != nil{
            ZStack{
                CardBackground()
                VStack(alignment:.leading){
                    PaymentMethodDisplayTitle(title: "付款方式", imageString: "pencil.circle",displayBool: $directDebitRegistrationDisplay)
                    DividerView(width: 1)
                    VStack {
                        Spacer()
                            .frame(height: 6.0)
                        branchNumber
                        
                    }
                    VStack {
                        Spacer()
                            .frame(height: 6.0)
                        transitNumber
                    }
                    VStack {
                        Spacer()
                            .frame(height: 6.0)
                        accountNumber
                    }
                    
                }
                .padding(.all)
            }
        }
        
        
    }
    
    // for credit cards
    
    var cardNumber: some View{
        
        HStack(alignment:.center){
            Text("总计")
                .foregroundColor(Color("white"))
            Spacer()
            Text(storedCardInfo!.CardNumber)
                .foregroundColor(Color("white"))
        }
    }
    
    var cardExpDate:some View{
        HStack(alignment:.center){
            Text("总计")
                .foregroundColor(Color("white"))
            Spacer()
            Text("\(storedCardInfo!.ExpYear)/\(storedCardInfo!.ExpMonth)")
                .foregroundColor(Color("white"))
        }
    }
    
    // for direct debit
    var branchNumber: some View{
        HStack(alignment:.center){
            Text("Branch number")
                .foregroundColor(Color("white"))
            Spacer()
            Text(String(directDebitInfo!.RoutingNumber.prefix(5)))
                .foregroundColor(Color("white"))
        }
    }
    var transitNumber: some View{
        HStack(alignment:.center){
            Text("Branch number")
                .foregroundColor(Color("white"))
            Spacer()
            Text(String(directDebitInfo!.RoutingNumber.suffix(3)))
                .foregroundColor(Color("white"))
        }
    }
    
    var accountNumber: some View{
        HStack(alignment:.center){
            Text("Branch number")
                .foregroundColor(Color("white"))
            Spacer()
            Text(String(directDebitInfo!.AccountNumber))
                .foregroundColor(Color("white"))
        }
    }
    
}

struct PurchaseAgreementDisplay: View {
    @Binding var isAgreementChecked:Bool
    @Binding var enteredName:String
    @ObservedObject var avoider:KeyboardAvoider
    var body: some View{
        ZStack(){
            CardBackground()
            VStack(alignment: .leading){
                PurchaseInfoTitle(title: "服务协议", imageString: "pencil.circle")
                HStack {
                    Text("我已阅读并同意相关")
                        .foregroundColor(Color("gray"))
                    Spacer()
                        .frame(width:0)
                    Text("相关协议")
                        .foregroundColor(Color("white"))
                        .underline()
                    Spacer()
                    CheckBox(selected: $isAgreementChecked,color: Color("rare_gray"))
                    
                }
                VStack{
                    DividerView(width:0.5)
                    inputTextField
                    DividerView(width: 0.5)
                    
                }

                Text("By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .")
                    .foregroundColor(Color("gray"))
                    .fixedSize(horizontal: false, vertical: true)
                

            }
            .padding()
        }
    }
    var inputTextField: some View{
        ZStack(alignment: .leading) {
            if enteredName == ""{
                Text("Type your full name to confirm")
                    .foregroundColor(Color("white"))
            }
            TextField("",text: $enteredName,onEditingChanged:{_ in
                    self.avoider.editingField = 1
            })
                .foregroundColor(Color("white"))
            
            .avoidKeyboard(tag: 1)
        }
    }
}

struct CardBackground: View{
    var body: some View{
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(Color("card_background"))
    }
}


struct PurchaseBottomSheetContent: View{
    @Binding var cardShown: Bool
    @Binding var showDirectDebitPopUp: Bool
    @Binding var showCreditCardPopUp: Bool
    @Binding var paymentMethodDisplay: Bool
    @Binding var paymentMethodLoading: Bool
    @ObservedObject var shoppingCartManager:ShoppingCartManager
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
            
            shoppingCartManager.extractClientDirectDebitInfo
            {
                withAnimation{
                    paymentMethodLoading.toggle()
                    paymentMethodDisplay.toggle()
                    
                }
                print("\(String(describing: shoppingCartManager.directDebitInfo))" )
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
            shoppingCartManager.extractClientCreditCardInfo(
                if_user_has_one: {
                    withAnimation{
                        paymentMethodLoading.toggle()
                        paymentMethodDisplay.toggle()
                    }
                    print("\(String(describing: shoppingCartManager.creditCardInfo))" )
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


