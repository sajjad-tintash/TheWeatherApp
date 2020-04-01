//
//  WeatherParticular.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Holds the properties of a *WeatherParticular* object of Open Weather API and confirms to *Decodable* protocol
struct WeatherParticular: Decodable {
    var temp: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let seaLevel: Double?
    let humidity: Double?
    
    mutating func updateTemp(_ temprature:  Double?) {
        temp = temprature
    }
}
