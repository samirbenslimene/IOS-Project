//
//  CustomDateFormatter.swift
//  iProceed
//
//  Created by Apple Mac on 8/12/2021.
//

import Foundation

class DateUtils {
    
    static func formatFromString(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm.ss.SSZ"
        if let date = dateFormatter.date(from: string) {
            return date // "2015-05-15 21:58:00 +0000"
        }
        return Date()
    }
    
    static func formatFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        return dateFormatter.string(from: date)
    }
}
