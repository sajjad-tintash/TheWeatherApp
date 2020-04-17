//
//  HomeViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import SwiftUI

enum AppMode: Int, Identifiable, CaseIterable {
    case live = 1, offline = 0
    
    var id: AppMode {
        self
    }
    
    var text: String {
        return self == .live ? "Live" : "Offline"
    }
    
    mutating func toggle() {
        self = (self == .live ? .offline : .live)
    }
}

class HomeViewModel: ObservableObject {
    
    private(set) var model: CityWeatherModel
    @Published var mode: AppMode {
        willSet(newValue) {
            updateModel(newValue)
        }
    }
    @Published var searchText: String = "" {
        didSet {
            print(searchText)
        }
    }
    
    private var liveModel: CityWeatherModel?
    private var offlineModel: CityWeatherModel?
    
    init(model: CityWeatherModel, mode: AppMode) {
        self.model = model
        self.mode = mode
        
        liveModel = (mode == .live) ? model : nil
        offlineModel = (mode == .offline) ? model : nil
    }
    
    func updateModel(_ updatedMode: AppMode) {
        guard let dataModel = (updatedMode == .live) ? liveModel : offlineModel else {
            model = CityWeatherModel(weatherDateMap: [], city: nil)
            return
        }
        model = dataModel
    }
}
