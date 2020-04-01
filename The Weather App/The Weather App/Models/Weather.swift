//
//  Weather.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Holds the properties of a *Weather* object of  Open Weather API and confirms to *Decodable* protocol
struct Weather: Identifiable, Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
