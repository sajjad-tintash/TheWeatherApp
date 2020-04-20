//
//  SplashViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 09/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {

    @Published private(set) var shouldNavigateToHome: Bool = false
        
    private(set) var offlineData: CityWeatherModel = CityWeatherModel(weatherDateMap: []) {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
                self?.shouldNavigateToHome = true
            }
        }
    }
    fileprivate var weatherService: WeatherService = WeatherServiceFactory.weatherService(nil)
        
    func fetch(){
        weatherService.fetchWeatherForCity(nil) { [weak self]  (forcastResult, error) in
            self?.handlerForcastResponse(forcastResult, error: error)
        }
    }
    
}

extension SplashViewModel: ForcastMappable {
    /// Handles Forcast Service completion block
    /// - Parameters:
    ///   - forcastResult: ForcastResult  from weather service
    ///   - error: error srting from weather service
    func handlerForcastResponse(_ forcastResult: ForcastResult?, error: String?) {
        if let _ = error {
            //TODO:- propagate error
            offlineData = DummyHomeData.cityWeatherModel
        } else if let forcasts = forcastResult?.list {
            let dateWeatherMap = mapForcastsToDate(forcasts)
            offlineData = CityWeatherModel(weatherDateMap: dateWeatherMap, city: forcastResult?.city)
        }
    }
}
