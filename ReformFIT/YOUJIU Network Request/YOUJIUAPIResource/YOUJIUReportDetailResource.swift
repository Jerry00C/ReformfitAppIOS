//
//  YOUJIUReportDetailResource.swift
//  ChenReformFITPart (iOS)
//
//  Created by Chen Chen on 2021-09-14.
//

import Foundation

struct YOUJIUReportDetailRequest:Encodable{
    
}

struct YOUJIUReportDetailResponse:GeneralResponseType{
    typealias onSuccessResponse = SuccessfulYOUJIUReportDetailResponse
    
    typealias onErrorResponse = YOUJIUErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
    
}

struct SuccessfulYOUJIUReportDetailResponse: Decodable{
    let data: YOUJIUReportDetailData
    
    func generateYOUJIUDataModel()->YOUJIUReportDataModel{
        
        YOUJIUReportDataModel(id: data.measurement.id,
                              weight: data.measurement.weight,
                              bodyFat: data.measurement.outline.pbf,
                              muscleAmt: data.measurement.outline.smm,
                              muscleIndex: data.composition.ffmi,
                              reportTime: data.measurement.start_time,
                              gender: data.measurement.gender)
    }
    
}

struct YOUJIUReportDetailData:Decodable{
    let measurement:YOUJIUDetailMeasurement
    let composition:YOUJIUDetailComposition
}

struct YOUJIUDetailMeasurement: Decodable{
    let id:Int
    let weight:String
    let gender:Int
    let start_time:String
    let outline : YOUJIUDetailOutline
    
    
    
    
}

struct YOUJIUDetailOutline:Decodable{
    let pbf: Double
    let smm: Double
    
}

struct YOUJIUDetailComposition:Decodable{
    let ffmi:String//cant find ffmi , only ffm
}

struct YOUJIUReportDetailResource: YOUJIUAPIResource{
    
    
    

    
    typealias ResponseModelType = YOUJIUReportDetailResponse
    typealias RequestModelType = YOUJIUReportDetailRequest
    
    
    var methodPath:String = "/api/reports/"
    var queries: [URLQueryItem]?
    
    init(id:Int){
        methodPath  = methodPath + "\(id)"
    }
    
   
    
}
