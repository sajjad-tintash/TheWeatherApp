//
//  HomeViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import SwiftUI

/// main home screen's view model
class HomeViewModel: ObservableObject {
    
    /// Datasource, holds information of city and its weather forcast being shown on screen
    private(set) var model: CityWeatherModel
    
    /// Published property, user can switch it to live and offline
    @Published var mode: AppMode {
        willSet(newValue) {
            updateModel(newValue)
        }
    }
    
    /// Search query string
    var searchText: String = "" {
        didSet {
           filterCityBasedOnSearch(searchText)
        }
    }
    
    /// Data model containing live city and weather information
    private var liveModel: CityWeatherModel?
    /// Data model containing offline city and weather information
    private var offlineModel: CityWeatherModel?
    
    //MARK:- Properties for city search
    /// Service that fetches list of cities
    let offlineCityService:  OfflineCityService = OfflineCityService()
    /// Array containing list of all cities
    private var allCities: [City] = []
    
    /// Service that fetches weather data of a city
    var weatherService = WeatherServiceFactory.weatherService(NetworkHandler())
    
    /// Published property, sets with list of cities filtered based on search query
    @Published var filteredCities: [City] = []
    /// city selected by user after search
    var selectedCity: City? {
        didSet {
            isLoadingCity = true
            searchText = ""
            fetchWeatherForCity(selectedCity)
        }
    }
    
    /// Flag that indicates whether a service is loading city or not
    var isLoadingCity: Bool = false
    
    //MARK:- Initializer
    init(model: CityWeatherModel, mode: AppMode) {
        self.model = model
        self.mode = mode
        
        liveModel = (mode == .live) ? model : nil
        offlineModel = (mode == .offline) ? model : nil
        
        fetchAllCities()
    }
}


//MARK:- Setter for properties
extension HomeViewModel {
    /// Updates model based on state, sets live model to base model if provided mode was live else sets offline model
    /// - Parameter updatedMode: app mode
    fileprivate func updateModel(_ updatedMode: AppMode) {
        guard let dataModel = (updatedMode == .live) ? liveModel : offlineModel else {
            model = CityWeatherModel(weatherDateMap: [], city: nil)
            return
        }
        model = dataModel
    }
}

//MARK:- City search
extension HomeViewModel {
    /// Returns name of city at provided index
    /// - Parameter index: index
    func nameAtIndex(_ index: Int) -> String {
        guard (0 ..< filteredCities.count).contains(index) else { return "" }
        return filteredCities[index].fullName ?? ""
    }
    
    /// Calls offline service to fetch all cities
    fileprivate func fetchAllCities() {
        offlineCityService.fetchCities { [weak self] result in
            switch result {
            case .success(let cities):
                guard let cities = cities else {
                    //TODO:- Handle this case
                    return
                }
                self?.allCities = cities.compactMap({$0})
            case .failure( _):
                //TODO:- Propagate error
                break
            }
        }
    }
    
    /// Filters all cities based on provided search term, uses Levenshtein's distance
    /// - Parameter searchTerm: search term string
    fileprivate func filterCityBasedOnSearch(_ searchTerm: String) {
        clearFilteredList()
        guard searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).count > SearchTerm.minimumSearchTermCharacters else { return }
        let searchTerm = searchTerm.lowercased()
        let searchResults = allCities.filter { ($0.name?.lowercased().contains(searchTerm) ?? false) }.prefix(20)
        var sortedList = searchResults.sorted(by: {
            guard let firstDistance = $0.fullName?.levenshteinDistanceScore(to: searchTerm),
                let secondDistance = $1.fullName?.levenshteinDistanceScore(to: searchTerm) else {
                return false
            }
            return firstDistance > secondDistance
        })
        sortedList.removeAll(where: {
            $0.id == selectedCity?.id
        })
        filteredCities = sortedList
    }
    
    /// Resets filtered cities list
    fileprivate func clearFilteredList() {
        guard searchText.count < SearchTerm.minimumSearchTermCharacters, !filteredCities.isEmpty else { return }
        filteredCities = []
    }
}


extension HomeViewModel: ForcastMappable {
    /// Setter, sets selected city
    /// - Parameter city: *City*
    func selectCity(_ city: City) {
        selectedCity = city
    }
    
    /// Calls weather service to fetch weather of provided city
    /// - Parameter city: *City*
    fileprivate func fetchWeatherForCity(_ city: City?) {
        guard let cityId = city?.id else {
            return
        }
        weatherService.fetchWeatherForCity(String(cityId)) { [weak self]  result in
            self?.handlerForcastResponse(result: result)
        }
    }
    
    /// Handles response of weather service's fetch request
    /// - Parameters:
    ///   - forcastResult: forcast data
    ///   - error: error description string
    fileprivate func handlerForcastResponse(result: WeatherServiceResult) {
        switch result {
        case .success(let forcastResult):
            if let forcasts = forcastResult?.list {
                let dateWeatherMap = mapForcastsToDate(forcasts)
                liveModel = CityWeatherModel(weatherDateMap: dateWeatherMap, city: forcastResult?.city)
                updateModel(mode)
                isLoadingCity = false
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        case .failure(let error):
            //TODO:- Propagate Error
            print(error)
        }
    }
}
