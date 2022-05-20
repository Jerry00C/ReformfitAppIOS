//
//  PaymentPurchaseHistoryManager.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-08-26.
//

import Foundation


class PaymentPurchaseHistoryManager: ObservableObject{
    
   
    
    
    private var clientId: String
    
    @Published var clientPurchasedItems:[PurchasedItemModel]
    @Published var creditCardInfo:ClientCreditCardInfo?
    @Published var directDebitInfo:SuccessfulDirectDebitResponse?
    
    @Published var requestOrderCount:Int = 0
    
    init(clientId:String) {
        self.clientId = clientId
        
        self.clientPurchasedItems = []
        
    }
    func setClientId(new Id:String){
        self.clientId = Id
    }
    
    func getClientId()->String{
        self.clientId
    }
    
    //MARK: for extracting client purchased items
    func extractClientPurchasedItems(startDate:String?,endDate:String?,if_succeeded onCompletion:@escaping()->Void,if_failed onError:@escaping()->Void){
        let tokenRequest = AccessTokenInitializer.constructTokenRequest()
        tokenRequest.execute(){[weak self] response in
            if let realResponse = response?.OnSuccess {
                let accessToken = realResponse.AccessToken
                
                let purchaseHistoryResource = PurchaseHistoryResource(
                    clientid: self!.clientId,
                    startDate: startDate,
                    endDate: endDate)
                
                
                let purchaseHistoryRequest = MindbodyAPIRequest<PurchaseHistoryResource>(
                    resource: purchaseHistoryResource,
                    requestBody: nil,
                    method: "GET")
                
                purchaseHistoryRequest.addAuthKey(authToken: accessToken)
                purchaseHistoryRequest.execute{
                    [weak self] response in
                    
                    
                    if let realResponse = response?.OnSuccess{
                        var itemArray:[PurchasedItemModel] = []
                        for purchase in realResponse.Purchases{
                            let saleDate = purchase.Sale.SaleDate
                            
                            for purchasedItem in purchase.Sale.PurchasedItems{
                                let itemId = purchasedItem.Id
                                let amount = purchasedItem.TotalAmount
                                let description = purchasedItem.Description
                                
                                
                                let onePurchaseItem = PurchasedItemModel(
                                    purchaseItemId: itemId,
                                    saleDate: saleDate,
                                    description: description,
                                    totalAmount: amount)
                                
                                itemArray.append(onePurchaseItem)
                            }
                        }
                        
                        self?.clientPurchasedItems = itemArray
                        
                        onCompletion()
                    }
                    
                    else if let errorResponse = response?.OnError{
                        let errorMessage = errorResponse.error.Message
                        print("Error: \(errorMessage)\n")
                        onError()
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
                print("\(self?.clientId)")
                
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
    
    func asynchronousTaskCount(when_done taskOnComplete:@escaping()->Void){
        if requestOrderCount == 0{
            requestOrderCount+=1
        }
        
        else if requestOrderCount == 1{
            requestOrderCount+=1
        }
        
        else if requestOrderCount == 2{
            taskOnComplete()
        }
    }
    
    deinit {
        print("The current instance is deinitialized:")
        print("with credit info:\(String(describing: self.creditCardInfo))")
        print(" and sync count of : \(self.requestOrderCount)")
    }
}
