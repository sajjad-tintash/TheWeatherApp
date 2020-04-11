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

extension SplashViewModel {
    /// Handles Forcast Service completion block
    /// - Parameters:
    ///   - forcastResult: ForcastResult  from weather service
    ///   - error: error srting from weather service
    func handlerForcastResponse(_ forcastResult: ForcastResult?, error: String?) {
        if let _ = error {
            //TODO:- propagate error
            offlineData = DummyHomeData.cityWeatherModel
        } else if let forcasts = forcastResult?.list {
            let dateWeatherMap = forcastMapper(forcasts)
            offlineData = CityWeatherModel(weatherDateMap: dateWeatherMap, city: forcastResult?.city)
        }
    }
    
    /// Converts Forcast data into a date wise mapping, each forcast is placed under its own day so that a specific day's data can be shown
    /// Final array is sorted on date so that most recent date is at top
    /// - Parameter forcasts: array of *Forcast* objects
    func forcastMapper(_ forcasts: [Forcast?]) -> [WeatherDateMap]{
        let forcastDict = forcasts.reduce([Date: [Forcast]]()) { (dict, forcast) -> [Date: [Forcast]] in
            var dict = dict
            let forcastDateStr = forcast?.date?.dateStringWithoutTime()
            let date = forcastDateStr?.dateFromString()
            
            guard let unwrappedForcast = forcast, let unwrappedDate = date else {
                return dict
            }
            
            if var dateForcasts = dict[unwrappedDate]?.compactMap({$0}) {
                dateForcasts.append(unwrappedForcast)
                dict[unwrappedDate] = dateForcasts
            } else {
                dict[unwrappedDate] = [unwrappedForcast]
            }
            
            return dict
        }
        
        var dateWiseForcasts = forcastDict.compactMap { (arg) -> WeatherDateMap in
            let (key, value) = arg
            return WeatherDateMap(date: key, forcasts: value)
        }
        
        dateWiseForcasts = dateWiseForcasts.sorted(by: { $0.date > $1.date })
        return dateWiseForcasts
    }
}
