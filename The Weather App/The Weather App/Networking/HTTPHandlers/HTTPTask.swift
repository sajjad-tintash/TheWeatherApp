//
//  HTTPTask.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Defines request with *HTTPParameters* for  *URLRequest* query parameters
enum HTTPTask {
    case request(urlParams: HTTPParameters?)
}

