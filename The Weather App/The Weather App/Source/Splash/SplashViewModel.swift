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
        
    private(set) var offlineData: [WeatherDataMap] = []
        
    func fetch(){
        offlineData = DummyHomeData.weatherData
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.shouldNavigateToHome = true
        }
    }
}
