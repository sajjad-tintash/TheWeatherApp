//
//  CityWeatherModel.swift
//  The Weather App
//
//  Created by Sajjad on 11/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

struct WeatherDateMap: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let forcasts: [Forcast]
}

struct CityWeatherModel {
    var weatherDateMap: [WeatherDateMap]
    var city: City?

    var cityFullName: String {
        return city?.fullName ?? ""
    }
    
    var hasCityName: Bool {
        return city?.fullName != nil
    }
}
