//
//  WeatherServiceProtocol.swift
//  The Weather App
//
//  Created by Sajjad on 09/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

typealias WeatherCompletionBlock = (_ forcast: ForcastResult?,_ error: String?)-> ()

protocol WeatherService {
    func fetchWeatherForCity(_ cityId: String?, completion: @escaping WeatherCompletionBlock)
}
extension WeatherService {
    func fetchWeatherForCity(_ cityId: String?, completion: @escaping WeatherCompletionBlock) {
        if let service = self as? LiveWeatherService {
            guard let cityId =  cityId else { return }
            service.fetchWeatherForCity(cityId, completion: completion)
        }else if let service = self as? OfflineWeatherService {
            service.fetchWeather(completion)
        }
    }
}
