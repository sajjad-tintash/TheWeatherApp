//
//  EndPointType.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Defines Endpoint to provide required properties for any API endpoint
protocol EndPointType {
    var baseURL         : URL { get }
    var path            : String { get }
    var httpMethod      : HTTPMethod { get }
    var task            : HTTPTask { get }
    var cachingPolicy   : URLRequest.CachePolicy { get }
}
