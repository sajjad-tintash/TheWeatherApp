//
//  CityWeatherModel.swift
//  The Weather App
//
//  Created by Sajjad on 11/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Holds a date and associated *Array* of *Forcast* objects
struct WeatherDateMap: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let forcasts: [Forcast]
}

/// Holds information of  *City* aand its weather in the form of *Array* of *WeatherDateMap* objects
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
