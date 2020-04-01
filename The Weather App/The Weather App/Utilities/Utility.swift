//
//  Utility.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

enum Utility {
    /// Static function for temprature measurement unit based on user's locale settings.
    /// Returns string with three possible values  "imperial", "metric", "Kelvin"
    static func getUserTempUnit() -> String {
        let locale = NSLocale.current as NSLocale
        var tempUnit = "Kelvin"
        if let unitStr = locale.object(forKey: NSLocale.Key(rawValue: NotificationNames.kCFLocaleTemperatureUnitKey)) as? String {
            let localeTempUnit = unitStr.lowercased()
            switch localeTempUnit {
            case "fahrenheit":
                tempUnit = "imperial"
            case "celsius":
                tempUnit = "metric"
            default:
                tempUnit = "Kelvin"
            }
        }
        return tempUnit
    }
    
    /// Static function for temprature measurement unit symbol based on user's locale settings.
    /// Returns string with three possible values  "℉", "°C", "K"
    static func getUserTempUnitSymbol() -> String {
        let locale = NSLocale.current as NSLocale
        var tempUnit = "K"
        if let unitStr = locale.object(forKey: NSLocale.Key(rawValue: NotificationNames.kCFLocaleTemperatureUnitKey)) as? String {
            let localeTempUnit = unitStr.lowercased()
            switch localeTempUnit {
            case "fahrenheit":
                tempUnit = "℉"
            case "celsius":
                tempUnit = "°C"
            default:
                tempUnit = "K"
            }
        }
        return tempUnit
    }
    
    /// Converts temprature value from Farenheit to Celcius
    /// - Parameter farenheit: double value of temprature in Farenheit
    static func changeFarenheitToCelcius(_ farenheit: Double?) -> Double? {
        guard let farenheit = farenheit else { return nil }
        let celcius = (farenheit - 32.0) * 5.0/9.0
        return celcius
    }
}
