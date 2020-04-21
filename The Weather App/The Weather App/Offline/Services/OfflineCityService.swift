//
//  OfflineCityService.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

typealias OfflineFetchResult = Result<[City?]?, Error>

typealias CityCompletionBlock = (OfflineFetchResult)-> ()

/// Reads bundled cities json file which holds all the cities supported by *Open Weather API*
struct OfflineCityService: ReadsJsonFromFile, DecodesDataToModel {
    
    /// Reads bundled cities json file and decods into decodable *City* model array
    /// - Parameter completion: Completion closure with optional array of *City*  objects or error string
    func fetchCities(_ completion: @escaping CityCompletionBlock) {
        do {
            let jsonData = try dataFromJsonFile("cities")
            guard let data = jsonData else {
                completion(.failure(ServiceError.badRequest))
                return
            }
            let citiesList : [City?]? = try self.decodeModel(data: data)
            guard let cities = citiesList else {
                completion(.failure(ServiceError.noData))
                return
            }
            completion(.success(cities))
        } catch (let error){
            completion(.failure(error))
        }
    }
}
