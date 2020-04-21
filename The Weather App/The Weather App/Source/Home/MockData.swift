//
//  HomeDummyData.swift
//  The Weather App
//
//  Created by Sajjad on 08/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Holds mock data to be used in app
enum MockData {
    static let particular: WeatherParticular = {
        WeatherParticular(temp: 37.0, tempMin: nil, tempMax: nil, pressure: nil, seaLevel: nil, humidity: nil)
    }()
    static let forcast: Forcast = {
        Forcast(dateInterval: nil, date: Date(), weatherParticular: particular, weather: nil)
    }()
    static let weatherDataForOneDay: WeatherDateMap = {
        WeatherDateMap(date: Date(),forcasts: Array(repeating: forcast, count: 5))
    }()
    static let cityWeatherModel: CityWeatherModel = {
        CityWeatherModel(weatherDateMap: Array(repeating: weatherDataForOneDay, count: 5),
                         city: City(id: 1172451, name: "Lahore", country: "PK"))
    }()
}
