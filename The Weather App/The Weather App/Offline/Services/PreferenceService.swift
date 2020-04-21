//
//  PreferenceService.swift
//  The Weather App
//
//  Created by Sajjad on 21/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

struct PreferenceService {
    private let recentSearchedCityKey: String = "kRcentSearchedCity"
    
    func setRecentSearchedCityId(value: Int) {
        UserDefaults.standard.set(value, forKey: recentSearchedCityKey)
        UserDefaults.standard.synchronize()
    }
    
    func getRecentSearchedCityId() -> Int? {
        let value = UserDefaults.standard.value(forKey: recentSearchedCityKey) as?  Int
        return value
    }
}
