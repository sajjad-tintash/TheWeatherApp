//
//  HomeViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    private(set) var model: CityWeatherModel
    @Published var mode: AppMode {
        willSet(newValue) {
            updateModel(newValue)
        }
    }
    var searchText: String = "" {
        didSet {
           filterCityBasedOnSearch(searchText)
        }
    }
    
    private var liveModel: CityWeatherModel?
    private var offlineModel: CityWeatherModel?
    
    //MARK:- Properties for city search
    let offlineCityService:  OfflineCityService = OfflineCityService()
    private var allCities: [City] = []
    
    var weatherService = WeatherServiceFactory.weatherService(NetworkHandler())
    
    @Published var filteredCities: [City] = []
    var selectedCity: City? {
        didSet {
            isLoadingCity = true
            searchText = ""
            fetchWeatherForCity(selectedCity)
        }
    }
    
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
    func updateModel(_ updatedMode: AppMode) {
        guard let dataModel = (updatedMode == .live) ? liveModel : offlineModel else {
            model = CityWeatherModel(weatherDateMap: [], city: nil)
            return
        }
        model = dataModel
    }
}

//MARK:- City search
extension HomeViewModel {
    func nameAtIndex(_ index: Int) -> String {
        guard (0 ..< filteredCities.count).contains(index) else { return "" }
        return filteredCities[index].fullName ?? ""
    }
    
    func fetchAllCities() {
        offlineCityService.fetchCities { [weak self] (cities, error) in
            guard error == nil, let cities = cities else { return }
            self?.allCities = cities.compactMap({$0})
        }
    }
    
    func filterCityBasedOnSearch(_ searchTerm: String) {
        clearFilteredList()
        guard searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).count > SearchTerm.minimumSearchTermCharacters else { return }
        let searchTerm = searchTerm.lowercased()
        let searchResults = allCities.filter { ($0.name?.lowercased().contains(searchTerm) ?? false) }.prefix(20)
        filteredCities = searchResults.sorted(by: {
            guard let firstDistance = $0.fullName?.levenshteinDistanceScore(to: searchTerm),
                let secondDistance = $1.fullName?.levenshteinDistanceScore(to: searchTerm) else {
                return false
            }
            return firstDistance > secondDistance
        })
    }
    
    func clearFilteredList() {
        guard searchText.count < SearchTerm.minimumSearchTermCharacters, !filteredCities.isEmpty else { return }
        filteredCities = []
    }
}


extension HomeViewModel: ForcastMappable {
    func selectCity(_ city: City) {
        selectedCity = city
    }
    
    func fetchWeatherForCity(_ city: City?) {
        guard let cityId = city?.id else {
            return
        }
        
        weatherService.fetchWeatherForCity(String(cityId)) { [weak self]  (forcastResult, error) in
            self?.handlerForcastResponse(forcastResult, error: error)
        }
    }
    
    func handlerForcastResponse(_ forcastResult: ForcastResult?, error: String?) {
        if let error = error {
//            dataFetchErrorString.value = error
            print(error)
        } else if let forcasts = forcastResult?.list {
            let dateWeatherMap = mapForcastsToDate(forcasts)
            liveModel = CityWeatherModel(weatherDateMap: dateWeatherMap, city: forcastResult?.city)
            updateModel(mode)
            isLoadingCity = false
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
}
