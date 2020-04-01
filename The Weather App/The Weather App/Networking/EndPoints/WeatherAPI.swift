//
//  WeatherAPI.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation


/// Define different endpoint cases for the Open Weather API to be used for network requests
enum WeatherAPI {
    case forcast(city:String)
    case weatherImage(path:String)
}

extension WeatherAPI: EndPointType {
    
    /// Computed property for providing base url string based on API type
    private var baseURLString: String {
        switch self {
        case .weatherImage:
            return "http://openweathermap.org/img/wn/"
        default:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }
    
    /// Computed property for providing a *URL* with the base url string
    var baseURL: URL {
        guard let url = URL(string: baseURLString) else {fatalError("Invalid Base URL.")}
        return url
    }
    
    /// Computed property to provide specific path for each API end point
    var path: String {
        switch self {
        case .forcast:
            return "forecast"
        case .weatherImage(let path):
            return "\(path)@2x.png"
        }
    }
    
    /// Computed property to provide HTTP request method to be used in network request
    var httpMethod: HTTPMethod {
        return .get
    }
    
    /// Computed property to provide request with specific query string parameters if required
    var task: HTTPTask {
        var params : HTTPParameters? = nil
        switch self {
         case .forcast(let city):
            params  = ["appid": WeatherAPIKey.key, "id": city, "units":Utility.getUserTempUnit()]
         case .weatherImage:
            params = nil
        }
        return .request(urlParams: params)
    }
    
    /// Computed property to provide request with cache  policy
    var cachingPolicy: URLRequest.CachePolicy {
        switch self {
         case .forcast:
            return .reloadIgnoringLocalCacheData
         case .weatherImage:
            return .returnCacheDataElseLoad
        }
    }
}
