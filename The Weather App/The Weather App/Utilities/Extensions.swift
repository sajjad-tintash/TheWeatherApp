//
//  Extensions.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

extension Date {
    /// Returns string for date without time components in formate *YYYY-MM-dd*
    func dateStringWithoutTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }
    /// Returns string for time without date components in formate *h:mm a*
    func timeStringWithoutDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
}
extension String {
    /// Returns date for string without time components in formate *YYYY-MM-dd*.
    /// Returns nil if string is not a valid date convertable
    func dateFromString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from: self)
    }
}
extension Double {
    
    /// Returns string for double to required decimal places
    /// - Parameter f: String with required number of decimal places, for  example "0.2" for two decimal places
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
