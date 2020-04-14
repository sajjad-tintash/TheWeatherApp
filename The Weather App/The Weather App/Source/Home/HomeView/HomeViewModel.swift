//
//  HomeViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

enum AppMode: Int, Identifiable, CaseIterable {
    case live = 1, offline = 0
    
    var id: AppMode {
        self
    }
    
    var text: String {
        return self == .live ? "Live" : "Offline"
    }
}

class HomeViewModel: ObservableObject {
    
    @Published private(set) var model: CityWeatherModel
    @Published var mode: AppMode = .offline
    
    init(model: CityWeatherModel) {
        self.model = model
    }
    
    
}
