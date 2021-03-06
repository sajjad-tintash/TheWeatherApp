//
//  DailyForcastViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

class DailyForcastViewModel: ObservableObject {
    
    /// Holds information of date and corresponding list of *Forcast* objects
    @Published private(set) var model: WeatherDateMap
    
    init(model: WeatherDateMap) {
        self.model = model
    }
}
