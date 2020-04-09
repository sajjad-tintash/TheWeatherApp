//
//  WeatherServiceFactory.swift
//  The Weather App
//
//  Created by Sajjad on 09/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

struct WeatherServiceFactory: WeatherService {
    private init() {}
    static func weatherService(_ networkHandler: NetworkHandler?) -> WeatherService {
        guard let handler = networkHandler else { return OfflineWeatherService()}
        return LiveWeatherService(handler)
    }
}
