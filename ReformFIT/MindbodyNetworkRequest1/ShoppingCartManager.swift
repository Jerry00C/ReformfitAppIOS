//
//  ShoppingCartManager.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-08.
//

import Foundation


class ShoppingCartManager: ObservableObject{
    
    var shoppingCartRequest:ShoppingCartRequest
    private var test: Bool = true
    private var clientId:String
    private var serviceId:Int
    private var quantity:Int = 1
    private var inStore:Bool = true
    private var paymentMethods:[Payment] = []
    
    //MARK: the code and card numbers are to update the view in corresponding times
    @Published var promotionCode:String?
    @Published var giftCardNumber:String?
    
    //MARK: gift card amount is used to calculate total needed to be paid by users card
    var giftCardAmount:Double?
    
    //MARK: keeping track of original price, price after discount and discounted amount
    @Published var currentTotal:Double?
    @Published var originalTotal: Double?
    @Published var discountedAmount: Double?
    
    //MARK: user credit card info to be updated and displayed
    @Published var creditCardInfo: ClientCreditCardInfo?
    
    //MARK: user direct debit info to be updated and displayed
    @Published var directDebitInfo: SuccessfulDirectDebitResponse?
    
    init(clientId:String, serviceId:Int) {
        self.clientId = clientId
        self.serviceId = serviceId
        self.shoppingCartRequest = ShoppingCartRequest(
            ClientId: self.clientId,
            Test: self.test,
            Items: [CartItem(serviceId: self.serviceId, quantity: self.quantity)],
            PromotionCode: "",
            InStore: self.inStore,
            Payments: self.paymentMethods)
    }
    
    func addPayment(amount:Payment){
        paymentMethods.append(amount)
        shoppingCartRequest.updatePayments(payments: self.paymentMethods)
    }
    func addGiftCard(amount:Payment){
        if paymentMethods.count == 1{
            // case where the cart only have comp, then add a gift card
            addPayment(amount: amount)
            print(paymentMethods)
        }
        else {
            // replace the old gift card with the new one
            paymentMethods[1] = amount
            shoppingCartRequest.updatePayments(payments: paymentMethods)
            print(paymentMethods)
        }
    }
    
    func updatePromoCode(with newCode:String){
        shoppingCartRequest.updatePromoCode(with: newCode)
    }
    
    func setCartToOfficial(){
        shoppingCartRequest.setTestToFalse()
    }
    
    
    //MARK: General function to process the posting of shopping cart
    func processShoppingCart(onCompetion:@escaping()->Void,onFailure:@escaping(_ totalGet:Bool)->Void){
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute(){[weak self] response in
            if let realResponse = response?.OnSuccess {
                print(realResponse.AccessToken)
                
                self?.postShoppingCart(authToken: realResponse.AccessToken, onCompletion: onCompetion, onFailure: onFailure)
                
    
                
            }
        }
    }
    
    //MARK: post the shopping cart

    func postShoppingCart(authToken: String , onCompletion:@escaping()->Void, onFailure:@escaping(_ totalGet:Bool)->Void){
        let shoppingCartResource = ShoppingCartResource(queries: nil)
        let postShoppingCartRequest = MindbodyAPIRequest<ShoppingCartResource>(resource: shoppingCartResource, requestBody: self.shoppingCartRequest, method: "POST")
        postShoppingCartRequest.addAuthKey(authToken: authToken)
        
        postShoppingCartRequest.execute(){
            [weak self] response in
            print("processed shopping cart...")
            print(response as Any)
                if let realResponse  = response?.OnSuccess {
                    let shoppingCartTotal = realResponse.ShoppingCart.GrandTotal
                    print(shoppingCartTotal)
                    onCompletion()
                }
            
                else if let errorResponse = response?.OnError{
                    print(errorResponse.error.Message)
                    let oldPromoCode = self?.promotionCode
                    self?.promotionCode = self?.shoppingCartRequest.getPromoCode()
                    let ifTotalGet = self?.getCartTotalFromErrorMessage(message: errorResponse.error.Message)
                    print(self?.currentTotal ?? 0.0)
                    //MARK: to put back the old promo code is the new one is not valid
                    if !ifTotalGet!{
                        self?.promotionCode = oldPromoCode
                    }
                    onFailure(ifTotalGet!)
                }
            
        }
        
    }
    
    
    //MARK: function to get the gift card balance and post the shopping card to calculate the price
    
    func getGiftCardBalance(barcodeId:String,onResponse onCompletion:@escaping()->Void,onErrorResponse onFailure:@escaping(_ totalGet:Bool)->Void){
        
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute(){[weak self] response in
            if let realResponse = response?.OnSuccess {
                print(realResponse.AccessToken)
                
        //MARK: requesting gift card balance section
                let accessToken = realResponse.AccessToken
                let giftCardBalanceResource = GiftCardBalanceResource(barcodeId: barcodeId)
                let getGiftCardBalanceRequest = MindbodyAPIRequest<GiftCardBalanceResource>(
                    resource: giftCardBalanceResource,
                    requestBody: nil,
                    method: "GET")
                getGiftCardBalanceRequest.addAuthKey(authToken: accessToken)
                getGiftCardBalanceRequest.execute(){[weak self]
                    response in
                    if let realResponse = response?.OnSuccess{
                        let remainingAmount = realResponse.RemainingBalance
                        print("remaining amount on\(remainingAmount)")
                        if remainingAmount != 0{
                            self?.giftCardAmount = remainingAmount
                            let newGiftCard = SCartGiftCard(Amount: remainingAmount, CardNumber: barcodeId)
                            let giftCardPayment = Payment.giftCard(newGiftCard)
                            self?.addGiftCard(amount: giftCardPayment)
                            
            //MARK: posting shopping cart to check for the purchase total price
                            self?.postShoppingCart(
                                authToken: accessToken,
                                onCompletion: onCompletion,
                                onFailure: onFailure
                            )
                        }
                        else{
                            onFailure(false)
                            print("gift card with 0 amount, invalid")
                        }
                    }
                    else if let errorResponse = response?.OnError{
                        let errorMessage = errorResponse.error.Message
                        onFailure(false)
                        print(errorMessage)
                    }
                    
                }
                
            }
        }
    }
    
    //MARK: below is client credit card section
    func extractClientCreditCardInfo(if_user_has_one OnCompletion:@escaping()->Void,if_Null onNull:@escaping()->Void){
        
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute(){[weak self] response in
            if let realResponse = response?.OnSuccess {
                print(realResponse.AccessToken)
                
                let accessToken = realResponse.AccessToken
                
                let clientCreditCardResource = GetClientCreditCardResource(clientId: self?.clientId ?? "")
                
                let clientCreditCardRequest = MindbodyAPIRequest<GetClientCreditCardResource>(
                    resource: clientCreditCardResource,
                    requestBody: nil,
                    method: "GET")
                clientCreditCardRequest.addAuthKey(authToken: accessToken)
                clientCreditCardRequest.execute(){[weak self] response in
                    if let realResponse = response?.OnSuccess{
                        let chosenClient = realResponse.Clients[0]
                        if let clientCreditCardInfo = chosenClient.ClientCreditCard{
                            self?.creditCardInfo = clientCreditCardInfo
                            print("\(clientCreditCardInfo)\n")
                            OnCompletion()
                        }
                        else{
                            print(" User has no credit card registered yet.\n")
                            onNull()
                        }
                        
                    
                    }
                    else if let errorResponse = response?.OnError{
                        let errorMessage = errorResponse.error.Message
                        print("Error: \(errorMessage)\n")
                    }
                    
                }
            }
        }
    }
    
    func updateClientCreditCardInfo(newCreditCardInfo:ClientCreditCardInfo,If_Succeeded onCompletion:@escaping()->Void,If_Error onError:@escaping()->Void){
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute(){[weak self] response in
            if let realResponse = response?.OnSuccess{
                let accessToken = realResponse.AccessToken
                
                
               
                
                // Initialize the client json object
                let clientInfo = CreditCard_Client(
                    ClientCreditCard: newCreditCardInfo,
                    Id: self?.clientId ?? "")
                
                let CCRequestBody = UpdateCreditCardRequest(
                    Client: clientInfo,
                    CrossRegionalUpdate: false,
                    Test: false)
                
                // initialize the request
                
                let updateCreditCardResource = UpdateCreditCardResource(queries: nil)
                
                let updateCreditCardRequest = MindbodyAPIRequest<UpdateCreditCardResource>(resource: updateCreditCardResource, requestBody: CCRequestBody, method: "POST")
                
                updateCreditCardRequest.addAuthKey(authToken: accessToken)
                updateCreditCardRequest.execute(){[weak self] response in
                    if let realResponse = response?.OnSuccess{
                        
                        self?.creditCardInfo = realResponse.Client.ClientCreditCard
                        onCompletion()
                        
                        
                    }
                    
                    else if let errorResponse = response?.OnError{
                        let errorMessage = errorResponse.error.Message
                        print(errorMessage)
                    }
                    
                }
                
                
            }
            
            
        }
    }
    
    //MARK: below is client direct debit section
    
    func extractClientDirectDebitInfo(if_user_has_one OnCompletion:@escaping()->Void,if_user_has_no_debit onError:@escaping()->Void){
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute(){[weak self] response in
            if let realResponse = response?.OnSuccess{
                let accessToken = realResponse.AccessToken
                
                let getDirectDebitResource = GetClientDirectDebitResource(clientId: self?.clientId ?? "")
                
                let directDebitRequest = MindbodyAPIRequest<GetClientDirectDebitResource>(resource: getDirectDebitResource, requestBody: nil, method: "GET")
                
                directDebitRequest.addAuthKey(authToken: accessToken)
                directDebitRequest.execute{
                    [weak self] response in
                    if let realResponse = response?.OnSuccess{
                        self?.directDebitInfo = realResponse
                        OnCompletion()
                    }
                    else if response?.OnSuccess == nil{
                        print("User does not have a debit card yet")
                        onError()
                    }
                    
                    else if let errorResponse = response?.OnError{
                        
                        print("get Direct debit failed: \(errorResponse)")
                        onError()
                    }
                }
            }
            
        }
    }
    
    func addClientDirectDebitInfo(newDirectDebitInfo:AddClientDirectDebitRequest,If_Succeeded onCompletion:@escaping()->Void,If_Error onError:@escaping()->Void){
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute(){[weak self] response in
            if let realResponse = response?.OnSuccess{
                let accessToken = realResponse.AccessToken
                
                
                // initialize the request
                
                let addDirectDebitResource = AddClientDirectDebitResource(queries: nil)
                
                let addDirectDebitRequest = MindbodyAPIRequest<AddClientDirectDebitResource>(resource: addDirectDebitResource, requestBody: newDirectDebitInfo, method: "POST")
                print(newDirectDebitInfo)
                addDirectDebitRequest.addAuthKey(authToken: accessToken)
                addDirectDebitRequest.execute(){[weak self] response in
                    if let realResponse = response?.OnSuccess{
                        
                        self?.directDebitInfo = realResponse
                        onCompletion()
                        
                        
                    }
                    
                    else if let errorResponse = response?.OnError{
                        let errorMessage = errorResponse.error.Message
                        print(errorMessage)
                        onError()
                    }
                    
                }
                
                
            }
            
            
        }
    }
    
    //MARK: function that takes the error message from shopping cart response to calculate the right amount to display
    func getCartTotalFromErrorMessage(message:String)->Bool{
        let decimal = message.components(separatedBy: CharacterSet.init(charactersIn: "0123456789.").inverted)
        var realValue:Double = -1
        var counter = 0
        for item in decimal{
            if let number = Double(item) {
                counter+=1
//                print("number: \(number)")
                if counter == 2{
                    realValue = number
                }
            }
        }
        if realValue != -1{
            
            if originalTotal == nil{
                //MARK: default case where no discount is provided
                currentTotal = realValue
                discountedAmount = 0
            }
            else if let _giftCardAmount = giftCardAmount{
                if _giftCardAmount >= realValue && realValue == originalTotal{
                    currentTotal = 0
                    discountedAmount = realValue
                    if _giftCardAmount>realValue{
                        paymentMethods[1].changeGiftCardAmount(new: realValue)
                        shoppingCartRequest.Payments = paymentMethods
                        print("\nat this moment: \(shoppingCartRequest.Payments)\n")
                    }
                }
                else if _giftCardAmount < realValue && realValue == originalTotal{
                    
                    currentTotal = Double.accuratelySubtract(value1:realValue,value2:_giftCardAmount)
                    discountedAmount = _giftCardAmount
                }
                
                else if _giftCardAmount >= realValue && realValue != originalTotal{
                    currentTotal = 0
                    discountedAmount = originalTotal
                    if _giftCardAmount>realValue{
                        paymentMethods[1].changeGiftCardAmount(new: realValue)
                        shoppingCartRequest.Payments = paymentMethods
                    }
                }
                
                else if _giftCardAmount < realValue && realValue != originalTotal{
                    print("\(realValue) - \(_giftCardAmount)")
                    
                    currentTotal = Double.accuratelySubtract(value1:realValue,value2:_giftCardAmount)
                    
                    let promoDiscount = Double.accuratelySubtract(value1: originalTotal!, value2: realValue)
                    discountedAmount = promoDiscount + _giftCardAmount
                }
            }
            else {
                if realValue < originalTotal!{
                    currentTotal = realValue
                    
                    discountedAmount = Double.accuratelySubtract(value1: originalTotal!, value2: realValue)
                }
            }
            
            return true
        }
        else {
            print("Error Message does not contain real purchase total")
            return false
        }
    }
    
    
    
    
    
}



