//
//  DateHelper.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 20/1/2023.
//

import Foundation

class DateHelper {
    
     func formatFromDateToTimestamp (date: String) -> TimeInterval {
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh"
        let date = dateFormatter.date(from: date)
        let timestamp = date!.timeIntervalSince1970
        return timestamp
        
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
    
}
