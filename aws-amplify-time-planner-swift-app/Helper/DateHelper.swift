//
//  DateHelper.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 20/1/2023.
//

import Foundation

class DateHelper {
    
     func formatFromDateStringToTimestamp (date: String) -> TimeInterval {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH"
        let date = dateFormatter.date(from: date)
         let timestamp = date?.timeIntervalSince1970
        return timestamp ?? 0
    }
    
    func formatFromDateToDateString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func formateFromDateStringToDate (dateString: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    func formateFromDateWithHourStringToDate (dateString: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH"
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    func formatFromDateToTimestamp (date:Date) -> TimeInterval{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH"
        let dateString = dateFormatter.string(from: date)
        let formattedDate = dateFormatter.date(from: dateString)
        let timestamp = formattedDate!.timeIntervalSince1970
        return timestamp
    }
    
}
