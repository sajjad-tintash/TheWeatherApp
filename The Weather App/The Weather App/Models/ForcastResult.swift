//
//  ForcastResult.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Holds the properties of Open Weather API response object and confirms to *Decodable* protocol
struct ForcastResult: Decodable {
    let cod: String?
    let cnt: Int?
    var list: [Forcast?]?
    let city: City?
}
