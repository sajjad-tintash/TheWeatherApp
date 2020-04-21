//
//  Extensions.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

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
    
    /// Returns string with day and date
    func dayAndDateStringWithoutTime() -> String {
        let dateWithoutTime = dateStringWithoutTime()
        let weekDay = Calendar.current.component(.weekday, from: self)
        let weekDayName = DateFormatter().shortWeekdaySymbols[weekDay-1]
        return weekDayName + ", " + dateWithoutTime
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
    
    /// Uses Leveenshtein algorithm to calculate distance score with a string
    /// - Parameters:
    ///   - string: to compare with
    ///   - ignoreCase: boolean
    ///   - trimWhiteSpacesAndNewLines: boolean
    func levenshteinDistanceScore(to string: String, ignoreCase: Bool = true, trimWhiteSpacesAndNewLines: Bool = true) -> Double {

        var firstString = self
        var secondString = string

        if ignoreCase {
            firstString = firstString.lowercased()
            secondString = secondString.lowercased()
        }
        if trimWhiteSpacesAndNewLines {
            firstString = firstString.trimmingCharacters(in: .whitespacesAndNewlines)
            secondString = secondString.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        let empty = [Int](repeating:0, count: secondString.count)
        var last = [Int](0...secondString.count)

        for (i, tLett) in firstString.enumerated() {
            var cur = [i + 1] + empty
            for (j, sLett) in secondString.enumerated() {
                cur[j + 1] = tLett == sLett ? last[j] : Swift.min(last[j], last[j + 1], cur[j])+1
            }
            last = cur
        }

        // maximum string length between the two
        let lowestScore = max(firstString.count, secondString.count)

        if let validDistance = last.last {
            return  1 - (Double(validDistance) / Double(lowestScore))
        }

        return 0.0
    }
}
extension Double {
    
    /// Returns string for double to required decimal places
    /// - Parameter f: String with required number of decimal places, for  example "0.2" for two decimal places
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
