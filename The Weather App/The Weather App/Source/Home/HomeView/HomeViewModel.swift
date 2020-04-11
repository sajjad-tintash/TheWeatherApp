//
//  HomeViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

enum AppMode: String {
    case live = "Live", offline = "Offline"
}

class HomeViewModel: ObservableObject {
    
    @Published private(set) var model: CityWeatherModel
    @Published private(set) var mode: AppMode = .offline
    
    init(model: CityWeatherModel) {
        self.model = model
    }
}
