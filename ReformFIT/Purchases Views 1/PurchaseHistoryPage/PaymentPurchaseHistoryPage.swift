//
//  PaymentPurchaseHistoryPage.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-08-25.
//

import SwiftUI

struct PaymentPurchaseHistoryPage: View {
    
    private let clientId:String
    
    @ObservedObject var purchaseHistoryManager:PaymentPurchaseHistoryManager
    
    
//    @State var initialLoading:Bool = false
    @State var initialLoading:Bool = true
    @State var loggedInLoading:Bool = true
    @State var paymentMethodLoading = false
    @State var historyLoading = false
    
    
    //bottom sheet display state
    @State var bottomSheetShown = false
    @State var bottomSheetDismissal = false
    
    // direct debit setup pop up display state
    @State var displayDirectDebitSetup = false
    
    // credit card setup pop up display state
    @State var displayCreditCardSetup = false
    
    //MARK: credit card Info state to be entered
    
    @State var newCreditCardInfo:ClientCreditCardInfo = ClientCreditCardInfo(Address: "", CardHolder: "", CardNumber: "", CardType: "", City: "", ExpMonth: "", ExpYear: "", PostalCode: "", State: "")
    @State var isCreditCardMissingField:Bool = false
    
    //
    @State var newDirectDebitInfo:AddClientDirectDebitRequest = AddClientDirectDebitRequest(Test: false, ClientId: "", NameOnAccount: "", RoutingNumber: "", AccountNumber: "", AccountType: "Savings")
    @State var isDirectDebitFieldMissing : Bool = false
    @State var branchNumber:String = ""
    @State var transitNumber:String = ""
    
    // payment method display state
    @State var paymentMethodDisplay:Bool = false
    
    
    @State var dateRangePickerDisplay = false
    // useless var below
    @State var cardDismissal = false
    
    @State var refreshModel = RefreshModel(started: false, released: false)
    
    init(clientId:String) {
        self.clientId = clientId
        self.purchaseHistoryManager = PaymentPurchaseHistoryManager(clientId: clientId)
        self.purchaseHistoryManager.extractClientCreditCardInfo(
            if_user_has_one: { [self] in
                purchaseHistoryManager.asynchronousTaskCount {[self] in
                            withAnimation{
                                print("when done initially call credit card info: \(purchaseHistoryManager.creditCardInfo!)")
//                                initialLoading.toggle()
                                print("it is logged in: \(globalVariable.logIn)")
                                if globalVariable.logIn{
                                    initialLoading = false
                                }
                            }
                        }
            },
            if_Null: {[self] in
//                        initialLoading.toggle()
                        purchaseHistoryManager.asynchronousTaskCount {[self] in
                            withAnimation{
//                                initialLoading.toggle()
                                print("it is logged in: \(globalVariable.logIn)")

                                if globalVariable.logIn{
                                    initialLoading = false
                                }
                            }
                        }
            }
        )

                purchaseHistoryManager.extractClientDirectDebitInfo(
                    if_user_has_one:{ [self] in
                        purchaseHistoryManager.asynchronousTaskCount{
                        [self] in
                            withAnimation{
//                                initialLoading.toggle()
                                print("it is logged in: \(globalVariable.logIn)")

                                if globalVariable.logIn{
                                    initialLoading = false
                                }
                            }
                        }
                    },
                    if_user_has_no_debit: {[self] in purchaseHistoryManager.asynchronousTaskCount{[self] in

                            withAnimation{
//                                initialLoading.toggle()
                                print("it is logged in: \(globalVariable.logIn)")

                                if globalVariable.logIn{
                                    initialLoading = false
                                }
                            }
                        }
                    }
                )

                purchaseHistoryManager.extractClientPurchasedItems(
                    startDate: nil,
                    endDate: nil,
                    if_succeeded: {[self] in purchaseHistoryManager.asynchronousTaskCount{
                        [self] in
                        withAnimation{
//                            initialLoading.toggle()
                            print("it is logged in: \(globalVariable.logIn)")

                            if globalVariable.logIn{
                                initialLoading = false
                            }
                        }
                    }
                },
                    if_failed: {[self] in purchaseHistoryManager.asynchronousTaskCount{[self] in
                            withAnimation{
//                                initialLoading.toggle()
                                print("it is logged in: \(globalVariable.logIn)")

                                if globalVariable.logIn{
                                    initialLoading = false
                                }
                            }
                        }
                    }
                )
            
        
    }
    var body: some View {
        ZStack{
            Color("main_background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                    
                    // this geometry reader is for refresh functionality
                    GeometryReader{ geo -> AnyView in
                        
//                        print(geo.frame(in: .global).minY)
                        DispatchQueue.main.async {
                            
                        
                            if refreshModel.startOffset == nil{
                                refreshModel.startOffset = geo.frame(in: .named("innerView")).minY
//                                print("startoffset: \(refreshModel.startOffset!)")
                            }
                            
                            refreshModel.offset = geo.frame(in: .named("innerView")).minY
//                            print("offset: \(refreshModel.offset)")
                            
                            if refreshModel.offset - refreshModel.startOffset! > 80 && !refreshModel.started{
                                refreshModel.started = true
                            }
                            
                            if refreshModel.startOffset! == refreshModel.offset && refreshModel.started && !refreshModel.released{
                                withAnimation{
                                    print("released")
                                    refreshModel.released = true
                                    updateDate()
                                }
                            }
                        }
                        return AnyView(Color("yellow").frame(width:0,height:0))
                    }
                    .frame(width:0, height: 0)
                    
                    
                    // refresher icons
                    ZStack(alignment:Alignment(horizontal: .center, vertical: .top)) {
                        if refreshModel.started && refreshModel.released{
                            ProgressView()
                                .foregroundColor(Color("white"))
                                .offset(y:15)
                        }
                        else {
                            Image(systemName: "arrow.down")
                                .foregroundColor(Color("gray"))
                                .rotationEffect(.init(degrees: refreshModel.started ? 180 :0))
                                .offset(y:-35)
                                .animation(.easeIn)
                        }
                        VStack(spacing: 20){
                            
    //                        if !initialLoading{
                                AvailablePaymentMethodDisplay(
                                    storedCardInfo: purchaseHistoryManager.creditCardInfo,
                                    directDebitInfo: purchaseHistoryManager.directDebitInfo,
                                    creditCardRegistrationDisplay: $displayCreditCardSetup,
                                    directDebitRegistrationDisplay: $displayDirectDebitSetup,
                                    bottomSheetForPaymentMethod: $bottomSheetShown)
                                    .padding(.horizontal)
    //                                .onAppear(){
    //                                    print("card info in the manager:\(String(describing: purchaseHistoryManager.creditCardInfo))")
    //                                    print("number of request count:\(purchaseHistoryManager.requestOrderCount)")
    //                                }
                            
                            PurchaseHistoryDisplay(purchasedItems: purchaseHistoryManager.clientPurchasedItems, dateRangePickerDisplay: $dateRangePickerDisplay)
                                .padding(.horizontal)
    //                        }
                        }
                        .offset(y: refreshModel.released ? 40 : -10)
                        
                        
                    }
                    
                }
                
            }
            .coordinateSpace(name: "innerView")
            
            paymentMethodBottomSheet
            dateRangeBottomSheet
            if displayCreditCardSetup {
                createNewCreditCardDialog
            }
            
            if displayDirectDebitSetup{
                createNewDirectDebitDialog
            }
            
            if paymentMethodLoading{
                LoadingScreen()
                
            }
            if historyLoading{
                LoadingScreen()
                
            }
            
//            if purchaseHistoryManager.requestOrderCount != 2{
//                initialLoadingScreen
//
//            }
            

            
            if globalVariable.logIn && loggedInLoading{
                initialLoadingScreen
                    .onAppear(){
                        DispatchQueue.main.async {
                            print("\(self.purchaseHistoryManager.getClientId())")
                            fetchClientInfo()
                        }
                        
                    }
            }
        }
    }
    var initialLoadingScreen: some View{
        
        InitialLoadingScreen()
    
    }
    
    var dateRangeBottomSheet: some View{
        BottomSheetView(
            cardShown: $dateRangePickerDisplay,
            cardDismissal: $cardDismissal,
            offset: UIScreen.main.bounds.height,
            whenExpanded: 20){
            DateRangePicker(dateSelectorCardShown: $dateRangePickerDisplay){
                startDate,endDate in
               
                let endDate = endDate
                print(startDate)
                print(endDate)
                let requestFormatter = DateFormatter()
                requestFormatter.dateFormat = "yyyy-MM-dd"
                var startDateInString:String? = requestFormatter.string(from: startDate)
                var endDateInString:String? = requestFormatter.string(from: endDate)
//                print(startDateInString)
//                print(endDateInString)
                withAnimation{
                    historyLoading = true
                }
                if startDate == endDate{
                    startDateInString = nil
                    endDateInString = nil
                }
                purchaseHistoryManager.extractClientPurchasedItems(
                    startDate: startDateInString,
                    endDate: endDateInString,
                    if_succeeded: {
                        withAnimation{
                            historyLoading = false
                        }
                },
                    if_failed: {
                        withAnimation{
                            historyLoading = false
                        }
                    }
                )
            }
        }
    }
    
    var paymentMethodBottomSheet: some View{
        BottomSheetView(cardShown:$bottomSheetShown, cardDismissal: $bottomSheetDismissal,offset:300, whenExpanded: 0){
            PaymentHistoryBottomSheetContent(
                cardShown: $bottomSheetShown,
                showDirectDebitPopUp: $displayDirectDebitSetup,
                showCreditCardPopUp: $displayCreditCardSetup,
                paymentMethodDisplay: $paymentMethodDisplay,
                paymentMethodLoading: $paymentMethodLoading,
                paymentPurchaseHistoryManager: self.purchaseHistoryManager
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
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
    
    var createNewCreditCardDialog: some View{
        ModalDialogView(
            showModal: $displayCreditCardSetup, title: "New credit card",
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
                        paymentMethodLoading = true
                        displayCreditCardSetup.toggle()
                    }
                    purchaseHistoryManager.updateClientCreditCardInfo(
                        newCreditCardInfo: newCreditCardInfo,
                        If_Succeeded: {
                            
                            print(purchaseHistoryManager.creditCardInfo!)
                            if !paymentMethodDisplay{
                                withAnimation(){
                                    paymentMethodLoading.toggle()
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
            showModal: $displayDirectDebitSetup, title: "New direct Debit",
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
                    
                    
                    purchaseHistoryManager.addClientDirectDebitInfo(
                        newDirectDebitInfo: newDirectDebitInfo,
                        If_Succeeded: {
                            
                            print(purchaseHistoryManager.directDebitInfo!)
                            if !paymentMethodDisplay{
                                withAnimation(){
                                    paymentMethodDisplay = true
                                }
                                withAnimation(){
                                    displayDirectDebitSetup.toggle()
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
    
    func fetchClientInfo(){
        DispatchQueue.main.async {
            self.purchaseHistoryManager.setClientId(new: globalVariable.clientId!)
            self.purchaseHistoryManager.extractClientCreditCardInfo(
                if_user_has_one: { [self] in
                    purchaseHistoryManager.asynchronousTaskCount {[self] in
                                withAnimation{
                                    print("when done initially call credit card info: \(purchaseHistoryManager.creditCardInfo!)")
    //                                initialLoading.toggle()
//                                    refreshModel.released = false
//                                    refreshModel.started = false
                                    loggedInLoading = false
                                }
                            }
                },
                if_Null: {[self] in
    //                        initialLoading.toggle()
                            purchaseHistoryManager.asynchronousTaskCount {[self] in
                                withAnimation{
    //                                initialLoading.toggle()
//                                    refreshModel.released = false
//                                    refreshModel.started = false
                                    loggedInLoading = false
                                }
                            }
                }
            )

                    purchaseHistoryManager.extractClientDirectDebitInfo(
                        if_user_has_one:{ [self] in
                            purchaseHistoryManager.asynchronousTaskCount{
                            [self] in
                                withAnimation{
    //                                initialLoading.toggle()
//                                    refreshModel.released = false
//                                    refreshModel.started = false
                                    loggedInLoading = false
                                }
                            }
                        },
                        if_user_has_no_debit: {[self] in purchaseHistoryManager.asynchronousTaskCount{[self] in

                                withAnimation{
    //                                initialLoading.toggle()
//                                    refreshModel.released = false
//                                    refreshModel.started = false
                                    loggedInLoading = false
                                }
                            }
                        }
                    )

                    purchaseHistoryManager.extractClientPurchasedItems(
                        startDate: nil,
                        endDate: nil,
                        if_succeeded: {[self] in purchaseHistoryManager.asynchronousTaskCount{
                            [self] in
                            withAnimation{
    //                            initialLoading.toggle()
//                                refreshModel.released = false
//                                refreshModel.started = false
                                loggedInLoading = false
                            }
                        }
                    },
                        if_failed: {[self] in purchaseHistoryManager.asynchronousTaskCount{[self] in
                                withAnimation{
    //                                initialLoading.toggle()
//                                    refreshModel.released = false
//                                    refreshModel.started = false
                                    loggedInLoading = false
                                }
                            }
                        }
                    )
        
        }
    }
    
    func updateDate(){
        DispatchQueue.main.async {
            self.purchaseHistoryManager.extractClientCreditCardInfo(
                if_user_has_one: { [self] in
                    purchaseHistoryManager.asynchronousTaskCount {[self] in
                                withAnimation{
                                    print("when done initially call credit card info: \(purchaseHistoryManager.creditCardInfo!)")
    //                                initialLoading.toggle()
                                    refreshModel.released = false
                                    refreshModel.started = false
                                }
                            }
                },
                if_Null: {[self] in
    //                        initialLoading.toggle()
                            purchaseHistoryManager.asynchronousTaskCount {[self] in
                                withAnimation{
    //                                initialLoading.toggle()
                                    refreshModel.released = false
                                    refreshModel.started = false
                                }
                            }
                }
            )

                    purchaseHistoryManager.extractClientDirectDebitInfo(
                        if_user_has_one:{ [self] in
                            purchaseHistoryManager.asynchronousTaskCount{
                            [self] in
                                withAnimation{
    //                                initialLoading.toggle()
                                    refreshModel.released = false
                                    refreshModel.started = false
                                }
                            }
                        },
                        if_user_has_no_debit: {[self] in purchaseHistoryManager.asynchronousTaskCount{[self] in

                                withAnimation{
    //                                initialLoading.toggle()
                                    refreshModel.released = false
                                    refreshModel.started = false
                                }
                            }
                        }
                    )

                    purchaseHistoryManager.extractClientPurchasedItems(
                        startDate: nil,
                        endDate: nil,
                        if_succeeded: {[self] in purchaseHistoryManager.asynchronousTaskCount{
                            [self] in
                            withAnimation{
    //                            initialLoading.toggle()
                                refreshModel.released = false
                                refreshModel.started = false
                            }
                        }
                    },
                        if_failed: {[self] in purchaseHistoryManager.asynchronousTaskCount{[self] in
                                withAnimation{
    //                                initialLoading.toggle()
                                    refreshModel.released = false
                                    refreshModel.started = false
                                }
                            }
                        }
                    )
        }
    }
}


// MARK: not workinfg
struct InitialLoadingScreen: View{
    
    
    
    var body: some View{
        LoadingScreen()

    
    }
}

struct RefreshModel{
    var startOffset:CGFloat?
    var offset: CGFloat = 0
    var started: Bool
    var released: Bool
}



struct PaymentHistoryBottomSheetContent: View{
    @Binding var cardShown: Bool
    @Binding var showDirectDebitPopUp: Bool
    @Binding var showCreditCardPopUp: Bool
    @Binding var paymentMethodDisplay: Bool
    @Binding var paymentMethodLoading: Bool
    @ObservedObject var paymentPurchaseHistoryManager:PaymentPurchaseHistoryManager
    
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
            
            paymentPurchaseHistoryManager.extractClientDirectDebitInfo
            {
                withAnimation{
                    paymentMethodLoading.toggle()
                    paymentMethodDisplay.toggle()
                    
                }
                print("\(String(describing: paymentPurchaseHistoryManager.directDebitInfo))" )
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
            
            paymentPurchaseHistoryManager.extractClientCreditCardInfo(
                if_user_has_one: {
                    withAnimation{
                        paymentMethodLoading.toggle()
                        paymentMethodDisplay.toggle()
                    }
                    print("\(String(describing: paymentPurchaseHistoryManager.creditCardInfo))" )
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
struct PurchaseHistoryDisplay:View{
    var purchasedItems:[PurchasedItemModel]?
    @Binding var dateRangePickerDisplay:Bool
    var body: some View{
        ZStack{
            CardBackground()
            VStack{
                PaymentMethodDisplayTitle(title: "购买历史", imageString: "pencil.circle",displayBool: $dateRangePickerDisplay)
                DividerView(width: 1)
                if let validPurchasedItems = purchasedItems{
                        if validPurchasedItems.count != 0{
                        VStack(alignment:.leading){
                            ForEach(validPurchasedItems){
                                data in
                                PurchasedItemDisplay(purchasedItem: data)
                                    .padding(.bottom)
                                
                                }
                            
                            }
                        }
                        else{
                            noItemsYetDisplay
                        }
                }
               
            }
            .padding(.all)
        }
    }
    var noItemsYetDisplay: some View{
        HStack{
            Spacer()
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30.0, height: 30.0)
            Text("No purchased item yet...")
            Spacer()
        }
        .foregroundColor(Color("gray"))
    }
    
    
}

struct PurchasedItemDisplay:View{
    var purchasedItem:PurchasedItemModel
    var body: some View{
        HStack{
            VStack(alignment:.leading){
                itemName
                purchasedDate
            }
            Spacer()
            purchasedPrice
        }
    }
    var itemName: some View{
        Text(purchasedItem.description)
            .font(.title3)
            .foregroundColor(Color("white"))
    }
    
    var purchasedDate: some View{
        Text(purchasedItem.saleDate)
            .foregroundColor(Color("white"))
    }
    
    var purchasedPrice: some View{
        Text(purchasedItem.totalAmount)
            .foregroundColor(Color("yellow"))
    }
}
struct AvailablePaymentMethodDisplay: View{
    
    var storedCardInfo:ClientCreditCardInfo?
    var directDebitInfo:SuccessfulDirectDebitResponse?
    @Binding var creditCardRegistrationDisplay:Bool
    @Binding var directDebitRegistrationDisplay:Bool
    @Binding var bottomSheetForPaymentMethod:Bool
    var body: some View{
        ZStack{
            CardBackground()
            VStack{
                PaymentMethodDisplayTitle(title: "付款方式", imageString: "pencil.circle",displayBool: $bottomSheetForPaymentMethod)
                DividerView(width: 1)
                // for credit card info display
                VStack {
                    Spacer()
                        .frame(height: 6.0)
                    cardNumber
                    Spacer()
                        .frame(height: 6.0)
                    cardExpDate
                    
                }
                .onAppear(){
                    print("stored card info:\(String(describing: storedCardInfo))")
                }
                DividerView(width: 1)
                
                // for direct debit info display
                VStack {
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
            }
            .padding(.all)
        }
    }
    
    // for credit cards
    
    var cardNumber: some View{
        
        HStack(alignment:.center){
            Text("总计")
                .foregroundColor(Color("white"))
            Spacer()
            if let cardNumber = storedCardInfo?.CardNumber{
                Text(cardNumber)
                    .foregroundColor(Color("white"))
            }
            else{
                Text("")
                    .foregroundColor(Color("white"))
            }
        }
    }
    
    var cardExpDate:some View{
        HStack(alignment:.center){
            Text("总计")
                .foregroundColor(Color("white"))
            Spacer()
            if let expYear = storedCardInfo?.ExpYear, let expMonth = storedCardInfo?.ExpMonth{
                Text("\(expYear)/\(expMonth)")
                    .foregroundColor(Color("white"))
            }
            else{
                Text("")
                    .foregroundColor(Color("white"))

            }
        }
    }
    
    // for direct debit
    var branchNumber: some View{
        HStack(alignment:.center){
            Text("Branch number")
                .foregroundColor(Color("white"))
            Spacer()
            if directDebitInfo != nil{
                Text(String(directDebitInfo!.RoutingNumber.prefix(5)))
                    .foregroundColor(Color("white"))
            }
            else {
                Text("")
                    .foregroundColor(Color("white"))

            }
        }
    }
    var transitNumber: some View{
        HStack(alignment:.center){
            Text("Branch number")
                .foregroundColor(Color("white"))
            Spacer()
            if directDebitInfo != nil{
                Text(String(directDebitInfo!.RoutingNumber.suffix(3)))
                    .foregroundColor(Color("white"))
            }
            else {
                Text("")
                    .foregroundColor(Color("white"))
            }
        }
    }
    
    var accountNumber: some View{
        HStack(alignment:.center){
            Text("Branch number")
                .foregroundColor(Color("white"))
            Spacer()
            if directDebitInfo != nil{
                Text(String(directDebitInfo!.AccountNumber))
                    .foregroundColor(Color("white"))
            }
            else {
                Text("")
                    .foregroundColor(Color("white"))
            }
            
        }
    }
}

struct PaymentPurchaseHistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPurchaseHistoryPage(clientId: "100013341")
    }
}
