//
//  Forcast.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Holds the properties of a *Forcast* object from Open Weather API and confirms to *Decodable* protocol
struct Forcast: Decodable, Identifiable {
    let id: UUID = UUID()
    let dateInterval: Int?
    let date: Date?
    var weatherParticular: WeatherParticular?
    let weather: [Weather?]?
    
    enum CodingKeys: String, CodingKey {
        case dateInterval = "dt"
        case date  = "dtTxt"
        case weatherParticular = "main"
        case weather
    }
}
