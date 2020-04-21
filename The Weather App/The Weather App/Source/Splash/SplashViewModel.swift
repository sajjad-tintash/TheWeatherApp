//
//  SplashViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 09/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import Combine

/// Splash screen view model
class SplashViewModel: ObservableObject {
    
    /// A plublished property, set true when application is ready to launch home screen
    @Published private(set) var shouldNavigateToHome: Bool = false
    
    /// Holds weather data
    private(set) var weatherData: CityWeatherModel = CityWeatherModel(weatherDateMap: []) {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
                self?.shouldNavigateToHome = true
            }
        }
    }
    
    /// Holds app mode
    private(set) var mode: AppMode = .offline
    
    /// Service that fetches offline weather data
    fileprivate var weatherService: WeatherService = WeatherServiceFactory.weatherService(nil)
        
    func fetch(){
        NetworkReachability.shared.checkNetworkConnection(result: { [unowned self] (isReachable) in
            if isReachable {
                let preference = PreferenceService()
                let id = preference.getRecentSearchedCityId()  ?? WeatherAPIKey.defaultCity.id ?? 1172451
                self.mode = .live
                self.weatherService = WeatherServiceFactory.weatherService(NetworkHandler())
                self.weatherService.fetchWeatherForCity(String(id)) { [weak self]  result in
                    self?.handlerForcastResponse(result: result)
                }
           } else {
                self.weatherService.fetchWeatherForCity(nil) { [weak self]  result in
                    self?.handlerForcastResponse(result: result)
                }
           }
        })
    }
}

/// Conforms to *ForcastMappable*
extension SplashViewModel: ForcastMappable {
    /// Handles Forcast Service completion block
    /// - Parameters:
    ///   - forcastResult: ForcastResult  from weather service
    ///   - error: error srting from weather service
    func handlerForcastResponse(result: WeatherServiceResult) {
        switch result {
        case .success(let forcastResult):
            guard let forcasts = forcastResult?.list else {
                //TODO:- propagate noData error
                return
            }
            let dateWeatherMap = mapForcastsToDate(forcasts)
            weatherData = CityWeatherModel(weatherDateMap: dateWeatherMap, city: forcastResult?.city)
        case .failure(_):
            //TODO:- propagate error
            weatherData = MockData.cityWeatherModel
        }
    }
}
