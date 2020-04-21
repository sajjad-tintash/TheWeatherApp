//
//  OfflineWeatherService.swift
//  The Weather App
//
//  Created by Sajjad on 09/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Reads bundled weather API result json file
struct OfflineWeatherService: WeatherService, ReadsJsonFromFile, DecodesDataToModel {
    
    /// Reads bundled weather API result json file and decods into decodable *ForcastResult* model
    /// - Parameter completion: Completion closure with  *ForcastResult*  objects or error string
    func fetchWeather(_ completion: @escaping WeatherCompletionBlock) {
        do {
            let jsonData = try dataFromJsonFile("lahore")
            guard let data = jsonData else {
                completion(nil,ServiceError.badRequest.localizedDescription)
                return
            }
            let forcastResultModel : ForcastResult? = try self.decodeModel(data: data)
            guard var forcastResult = forcastResultModel else {
                completion(nil, ServiceError.noData.localizedDescription)
                return
            }
            forcastResult.list = convertToCelciusIfRequired(forcastResult.list)
            completion(forcastResult, nil)
        } catch (let error){
            completion(nil, error.localizedDescription)
        }
    }
    func convertToCelciusIfRequired(_ forcasts: [Forcast?]?) -> [Forcast?]? {
        let locale = NSLocale.current as NSLocale
        guard let unitStr = locale.object(forKey: NSLocale.Key(rawValue: NotificationNames.kCFLocaleTemperatureUnitKey)) as? String, unitStr.lowercased() == "celsius" else { return forcasts }
        let celciusForcasts = forcasts?.map({ forcast -> Forcast? in
            var updatedForcast = forcast
            let celciusTemp = Utility.changeFarenheitToCelcius(forcast?.weatherParticular?.temp)
            updatedForcast?.weatherParticular?.updateTemp(celciusTemp)
            return updatedForcast
        })
        return celciusForcasts
    }
}
