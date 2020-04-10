//
//  HomeViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published private(set) var model: [WeatherDateMap]
    
    init(model: [WeatherDateMap]) {
        self.model = model
    }
}
