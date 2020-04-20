//
//  Constants.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

/// Holds constants for Open Weather API
enum WeatherAPIKey {
    static let key = "1241348d6b5e40a746e89639f3e1b32c"
    static let defaultCity = City(id: 1172451, name: "Lahore", country: "PK")
}

/// Holds constants for Notification names
enum NotificationNames {
    static let networkReachability = "networkReachability"
    static let kCFLocaleTemperatureUnitKey = "kCFLocaleTemperatureUnitKey"
}

enum Colors {
    static let themeColor = Color("basic-background")
}

/// Holds constants for Constraint values
enum SearchTerm {
    static let minimumSearchTermCharacters = 3
}

enum AppMode: Int, Identifiable, CaseIterable {
    case live = 1, offline = 0
    
    var id: AppMode {
        self
    }
    
    var text: String {
        return self == .live ? "Live" : "Offline"
    }
    
    mutating func toggle() {
        self = (self == .live ? .offline : .live)
    }
}
