//
//  ClassResourse.swift
//  ReformFIT
//
//  Created by J on 2021-08-03.
//

import Foundation

struct ClassResource: MindbodyAPIResource{

    
    typealias ResponseModelType = ClassInfoSResponse
    typealias RequestModelType = ClassInfoRequest
    
    var methodPath: String{
        "/public/v6/class/classes"
    }
    
    var queries: [URLQueryItem]?
    init(endDateTime: String, startDateTime: String) {
        
        queries = [
            URLQueryItem(name: "request.endDateTime", value: endDateTime),
            URLQueryItem(name: "request.limit", value: "200"),
            URLQueryItem(name: "request.startDateTime", value: startDateTime)
        ]
    }
   
    
}
struct ClassInfoSResponse: GeneralResponseType{
    typealias onSuccessResponse = ClassInfoResponse
    
    typealias onErrorResponse = ErrorResponse
    
    var OnSuccess: onSuccessResponse?
    var OnError: onErrorResponse?
    
}




struct ClassInfoRequest: Encodable{
    
    
}


struct ClassInfoResponse: Decodable{
    var classes: [Class]
    
    enum CodingKeys: String, CodingKey{
        case classes = "Classes"
    }
   
    
}

struct Class: Decodable{
    let classScheduleId: Int?
    let classId: Int?
    
    let startDateAndTime: String?
    let endDateAndTime: String?
    
    let maxCapacity: Int?
    let totalBooked: Int?
    let totalBookedWaitlist: Int?
    
    let isWaitlistAvailable: Bool?
    let isAvailable: Bool?
    let isCancel: Bool?
    
    
    var waitlist: Bool = false
    var waitlistEntryId: Int = 0
    var waitlistOrder = 0
    
    let virtualStreamLink: Int?
    
    let description: Description?
    let staff: Staff?
    let location: LocationPartial?
    
    
    enum CodingKeys: String, CodingKey{
        case classScheduleId = "ClassScheduleId"
        case classId = "Id"
        
        case startDateAndTime = "StartDateTime"
        case endDateAndTime = "EndDateTime"
        case maxCapacity = "MaxCapacity"
        case totalBooked = "TotalBooked"
        case totalBookedWaitlist = "TotalBookedWaitlist"
        case isWaitlistAvailable = "IsWaitlistAvailable"
        case isAvailable = "IsAvailable"
        case isCancel = "IsCanceled"
        case virtualStreamLink = "VirtualStreamLink"
        
        case description = "ClassDescription"
        case staff = "Staff"
        case location = "Location"
        
    }
    
}

struct Description: Decodable{
    
    let description: String?
    let className: String?
    let program: Program
    
    enum CodingKeys: String, CodingKey{
        case description = "Description"
        case className = "Name"
        case program = "Program"
    }
    
}


struct Staff: Decodable{
    
    let staffName: String?
    let staffDes: String?
    let staffImage: String?
    
    enum CodingKeys: String, CodingKey{
        
        
        case staffName = "Name"
        case staffDes = "Bio"
        case staffImage = "ImageUrl"
    }
}

struct Program: Decodable{
    let programName: String?
    let cancelOffset: Int?
    
    enum CodingKeys: String, CodingKey{
        
        case programName = "Name"
        case cancelOffset = "CancelOffset"
        
    }
    
    
}

struct LocationPartial: Decodable{
    let address: String?
    let address2: String?
    
    enum CodingKeys: String, CodingKey{
        
        case address = "Address"
        case address2 = "Address2"
    }
}



extension Class{
    
    var className: String?{
        return self.description?.className
    }
    
    var classDes: String?{
        return self.description?.description
    }
    
    
    var startDateDate: Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        
        return dateFormatter.date(from: (self.startDateAndTime?.replacingOccurrences(of: "T", with: ""))!)!
    }
    var startDate: String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        
        let fullDate = dateFormatter.date(from: (self.startDateAndTime?.replacingOccurrences(of: "T", with: ""))!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: fullDate!)
        
        
        
    }
    var startTime: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        let fullDate = dateFormatter.date(from: (self.startDateAndTime?.replacingOccurrences(of: "T", with: ""))!)
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: fullDate!)
        
        
    }
    var startDateCut: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fullDate = dateFormatter.date(from: self.startDate)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: fullDate!)
        
        
        
    }
    var startTimeCut: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let fullDate = dateFormatter.date(from: self.startTime)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: fullDate!)
        
        
        
    }
    var startTimestamp: Double{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        let fullDate = dateFormatter.date(from: (self.startDateAndTime?.replacingOccurrences(of: "T", with: "")) ?? "")
        return fullDate?.timeIntervalSince1970 ?? 0

    }
    var endDate: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        let fullDate = dateFormatter.date(from: (self.endDateAndTime?.replacingOccurrences(of: "T", with: ""))!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: fullDate!)
        
    }
    var endTime: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        let fullDate = dateFormatter.date(from: (self.endDateAndTime?.replacingOccurrences(of: "T", with: ""))!)
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: fullDate!)
        
    }
    var endDateCut: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fullDate = dateFormatter.date(from: self.endDate)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: fullDate!)
        
    }
    var endTimeCut: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let fullDate = dateFormatter.date(from: self.endTime)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: fullDate!)
        
    }
    var endTimeStamp: Double{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        let fullDate = dateFormatter.date(from: (self.endDateAndTime?.replacingOccurrences(of: "T", with: ""))!)
        return fullDate!.timeIntervalSince1970
    }
    
    var over: Bool{
        return endTimeStamp < NSDate().timeIntervalSince1970
        
    }
    
    var staff_imageUrl: String?{
        return self.staff?.staffImage
    }
    
    var staff_name: String?{
        return self.staff?.staffName
    }
    
    var staff_des: String?{
        return self.staff?.staffDes
    }
    
    
    var lateCancel: Bool?{
        let date = Date()
        print("date \(date)")
        let calendar = Calendar.current.date(byAdding: .hour, value: self.description?.program.cancelOffset ?? 0, to: date)

        print("added date \(String(describing: calendar))")
        
        let compared = calendar?.timeIntervalSince1970

        if compared ?? 0 > self.startTimestamp {
            return true

        }

        else{
            return false
        }
    }
    
    
}
