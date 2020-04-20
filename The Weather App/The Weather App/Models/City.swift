//
//  City.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Holds the properties of a *City* object of  Open Weather API and confirms to *Decodable* protocol
struct City: Decodable, Identifiable, Hashable {
    let id: Int?
    let name: String?
    let country: String?
    
    var fullName: String? {
        get {
            guard let name = self.name else { return nil }
            return name + ((country != nil) ? ", \(country ?? "")"  : "")
        }
    }
}
