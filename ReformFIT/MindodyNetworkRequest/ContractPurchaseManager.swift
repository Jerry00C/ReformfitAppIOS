//
//  ContractPurchaseManager.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-19.
//

import Foundation


class ContractPurchaseManager: ObservableObject{
    
    var contractPurchaseRequest: ContractPurchaseRequest
    var promoCodeTestShoppingCart: ShoppingCartRequest
    private var test: Bool = true
    private var locationId: Int
    private var clientId: String
    private var contractId: Int
    private var serviceId: Int
    private var StartDate:String?
    
    init(locationId:Int, clientId:String, contractId:Int, serviceid:Int) {
        self.locationId = locationId
        self.clientId = clientId
        self.contractId = contractId
        self.serviceId = serviceid
        self.contractPurchaseRequest = ContractPurchaseRequest(
            Test: self.test,
            LocationId: self.locationId,
            ClientId: self.clientId,
            ContractId: self.contractId,
            StartDate: self.StartDate,
            firstPaymentOccurs: "StartDate",
            PromotionCode: "",
            UseDirectDebit: false,
            StoredCardInfo: nil,
            SendNotification: false)
        self.promoCodeTestShoppingCart = ShoppingCartRequest(
            ClientId: self.clientId,
            Test: true,
            Items:  [CartItem(serviceId: self.serviceId, quantity: 1)],
            PromotionCode: "",
            InStore: true,
            Payments: [Payment.comp(SCartComp(Amount: 0))])
    }
    
    // MARK: promocode to be display
    @Published var promotionCode:String?
    
    //MARK: user credit card info to be updated and displayed
    @Published var creditCardInfo: ClientCreditCardInfo?

    
    //MARK: user direct debit info to be updated and displayed
    @Published var directDebitInfo: SuccessfulDirectDebitResponse?
    
    //MARK: price to be displayed
    @Published var originalTotal: Double?
    @Published var currentTotal: Double?
    @Published var discountedAmount: Double?
    
    
    func updatePromoCode(with newCode:String){
        // to add the entered promocode for checking validity
        promoCodeTestShoppingCart.updatePromoCode(with: newCode)
    }
    
    func updateStartDate(with newDateInString: String){
        contractPurchaseRequest.updateStartDate(with: newDateInString)
    }
    //MARK: function to post a purchase of contract
    func postContractPurchase(If_Succeeded onCompletion:@escaping()->Void,If_Failed onError:@escaping()->Void){
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute{
            [weak self] response in
            if let realResponse = response?.OnSuccess{
                let accessToken = realResponse.AccessToken
                let postPurchaseContractResource = ContractPurchaseResource(queries: nil)
                let postPurchaseContractRequest = MindbodyAPIRequest<ContractPurchaseResource>(resource: postPurchaseContractResource, requestBody: self?.contractPurchaseRequest, method: "POST")
                postPurchaseContractRequest.addAuthKey(authToken: accessToken)
                
                postPurchaseContractRequest.execute{
                    /*[weak self]*/ response in
                    if let successResponse = response?.OnSuccess{
                        print(successResponse)
                        onCompletion()
                    }
                    
                    if let errorResponse = response?.OnError{
                        print(errorResponse.error.Message)
                    }
                }
            }
        }
    }
    
    func setContractRequestOffical(){
        // set the contract request to be ready to proceed
        // set test to false
        contractPurchaseRequest.setTestToFalse()
        
        // apply the promocode
        contractPurchaseRequest.updatePromoCode(with: promotionCode ?? "")
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
        let postShoppingCartRequest = MindbodyAPIRequest<ShoppingCartResource>(resource: shoppingCartResource, requestBody: self.promoCodeTestShoppingCart, method: "POST")
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
                    self?.promotionCode = self?.promoCodeTestShoppingCart.getPromoCode()
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
            
//            if originalTotal == nil{
//                //MARK: default case where no discount is provided
//                currentTotal = realValue
//                discountedAmount = 0
//            }
            
             
            if realValue < originalTotal!{
                currentTotal = realValue
                
                discountedAmount = Double.accuratelySubtract(value1: originalTotal!, value2: realValue)
            }
            
            
            return true
        }
        else {
            print("Error Message does not contain real purchase total")
            return false
        }
    }
    
   
    
    
}
