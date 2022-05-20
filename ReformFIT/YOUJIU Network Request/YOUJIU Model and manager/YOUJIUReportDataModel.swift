//
//  YOUJIUReportDataModel.swift
//  ChenReformFITPart (iOS)
//
//  Created by Chen Chen on 2021-09-14.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG


struct YOUJIUReportDataModel:Equatable,Hashable{
    
    var id:Int
    var weight:String
    var bodyFat:Double
    var muscleAmt:Double
    var muscleIndex:String
    var reportTime:String
    var gender:Int
    
    init() {
        self.id = 0
        self.weight = ""
        self.bodyFat = 0
        self.muscleAmt = 0
        self.muscleIndex = ""
        self.reportTime = ""
        self.gender = 0
    }
    
    init(id: Int,
                          weight: String,
                          bodyFat: Double,
                          muscleAmt: Double,
                          muscleIndex: String,
                          reportTime: String,
                          gender: Int){
        self.id = id
        self.weight = weight
        self.bodyFat = bodyFat
        self.muscleAmt = muscleAmt
        self.muscleIndex = muscleIndex
        self.reportTime = reportTime
        self.gender = gender
    }
    
    func generateDetailedReportUrl()->URL{
        let timestamp = Int(Date().timeIntervalSince1970)
        
        let app_id = "977771291791745"
        let app_secret = "ZTkyMWU3ODljZWViZmI0NTA0MzA0MTcxNTRkMzM2OTY1ODg0N2UyZQ"
        let measurementId = self.id
        let md5Hex = MD5(string: app_id + app_secret + String(timestamp) + String(measurementId))
        let token:String = "third.\(measurementId).\(app_id).\(timestamp).\(md5Hex)"
        let url =  "https://c.youjiuhealth.com/index.html#/pages/report/show/show?id=\(measurementId)&token=" + token + "&lang=en_CA"
        return URL(string:url)!
    }
    
    func MD5(string: String) -> String {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
            let md5Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
            return md5Hex
        }

}
