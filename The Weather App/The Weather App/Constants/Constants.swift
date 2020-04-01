//
//  Constants.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import CoreLocation

/// Holds constants for Open Weather API
enum WeatherAPIKey {
    static let key = "1241348d6b5e40a746e89639f3e1b32c"
//    static let defaultCity = City(id: 1172451, name: "Lahore", country: "PK")
}

/// Holds constants for Notification names
enum NotificationNames {
    static let networkReachability = "networkReachability"
    static let kCFLocaleTemperatureUnitKey = "kCFLocaleTemperatureUnitKey"
}
