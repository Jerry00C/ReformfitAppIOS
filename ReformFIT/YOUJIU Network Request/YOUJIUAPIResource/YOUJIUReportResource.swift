//
//  YOUJIUReportResource.swift
//  ChenReformFITPart (iOS)
//
//  Created by Chen Chen on 2021-09-14.
//

import Foundation

struct YOUJIUReportRequest:Encodable{
    
}

struct YOUJIUReportResponse:GeneralResponseType{
    typealias onSuccessResponse = SuccessfulYOUJIUReportResponse
    
    typealias onErrorResponse = YOUJIUErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
}

struct SuccessfulYOUJIUReportResponse: Decodable{
    let data: [YOUJIUReportData]
    func getMeasurementIds()->[Int]{
        var measurementIdList:[Int] = []
        for oneReport in data{
            measurementIdList.append( oneReport.measurement.id)
        }
        return measurementIdList
    }
}

struct YOUJIUReportData:Decodable{
    let measurement:YOUJIUMeasurement
}

struct YOUJIUMeasurement: Decodable{
    let id:Int
}
struct YOUJIUReportResource: YOUJIUAPIResource{
    
    

    
    typealias ResponseModelType = YOUJIUReportResponse
    typealias RequestModelType = YOUJIUReportRequest
    
    
    var methodPath: String = "/api/reports"
    
    var queries: [URLQueryItem]?
    
    init(phoneNumber:String){
        queries = [
            URLQueryItem(name: "phone", value:phoneNumber)
        ]
    }
    
   
    
}
