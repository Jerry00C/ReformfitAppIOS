//
//  YOUJIUReportManager.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-12.
//

import Foundation


class YOUJIUReportManager:ObservableObject{
    
    @Published var measurementIds:[Int] = []
    @Published var listOfDataModels:[YOUJIUReportDataModel] = []
    @Published var loadingCounter = 0
    
    func initializeToken(onCompletion:@escaping(_:String)->Void){
        let tokenResource = YOUJIUTokenResource()
        let tokenRequest = YOUJIUAPIRequest<YOUJIUTokenResource>(resource: tokenResource, requestBody: nil, method: "POST")
        tokenRequest.execute(){
            response in
            if let successResponse = response?.OnSuccess{
//                print(successResponse.access_token)
                onCompletion(successResponse.access_token)
            }
        }
    }
    
    func getReport(accessToken:String,phoneNumber:String,onCompletion:@escaping()->Void){
        let reportResource = YOUJIUReportResource(phoneNumber: phoneNumber)
        let reportRequest = YOUJIUAPIRequest<YOUJIUReportResource>(resource: reportResource, requestBody: nil, method: "GET")
        reportRequest.addHeader(key: "Content-Type", value: "application/x-www-form-urlencoded")
        reportRequest.addHeader(key: "Authorization", value: "Bearer "+accessToken)
        reportRequest.execute{
            response in
            if let successResponse = response?.OnSuccess{
                let measurementIds = successResponse.getMeasurementIds()
                self.measurementIds = measurementIds
                self.listOfDataModels = Array(repeating: YOUJIUReportDataModel(), count: self.measurementIds.count)
//                onCompletion(measurementIds)
                for index in 0..<self.measurementIds.count{
                    
                    let id = self.measurementIds[index]
                    self.getMeasurementDetail(accessToken: accessToken, measurementId: id){
                        dataModel in
                        print(index)
                        self.listOfDataModels[index] = dataModel
                        self.loadingCounter+=1
                        if self.listOfDataModels.count == self.loadingCounter{
                            onCompletion()
                        }
                    }
                }
            }
            
            else if let errorResponse = response?.OnError{
                print(errorResponse.error.message)
            }
        }
    }
    
    func getMeasurementDetail(accessToken:String, measurementId:Int,onCompletion:@escaping(_:YOUJIUReportDataModel)->Void){
        let resource = YOUJIUReportDetailResource(id: measurementId)
        let request = YOUJIUAPIRequest<YOUJIUReportDetailResource>(resource: resource, requestBody: nil, method: "GET")
        request.addHeader(key: "Content-Type", value: "application/x-www-form-urlencoded")
        request.addHeader(key: "Authorization", value: "Bearer "+accessToken)
        
        request.execute{
            response in
            if let successResponse = response?.OnSuccess{
                let dataModel = successResponse.generateYOUJIUDataModel()
                onCompletion(dataModel)
            }
            
            else if let errorResponse = response?.OnError{
                print(errorResponse.error.message)
            }
        }
    }
}
