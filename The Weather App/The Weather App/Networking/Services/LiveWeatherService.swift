//
//  LiveWeatherService.swift
//  The Weather App
//
//  Created by Sajjad on 09/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Service for fetching Weather Forcast from the network
struct LiveWeatherService: WeatherService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension LiveWeatherService: DecodesDataToModel {
    
    /// Fetches the list of cras using the *WeatherAPI * *forcast* end point
    /// - Parameter completion: Completion closure with  *ForcastResult*  objects or error string
    func fetchWeatherForCity(_ cityId: String, completion: @escaping WeatherCompletionBlock) {
        networkHandler.fetchData(WeatherAPI.forcast(city: cityId), completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let forcastResultModel : ForcastResult? = try self.decodeModel(data: data)
                guard let forcastResult = forcastResultModel, let code = forcastResult.cod, code == "200" else {
                    completion(nil, ServiceError.failed.localizedDescription)
                    return
                }
                completion(forcastResult, nil)
            } catch {
                completion(nil, ServiceError.unableToDecode.localizedDescription)
            }
        })
    }
}
