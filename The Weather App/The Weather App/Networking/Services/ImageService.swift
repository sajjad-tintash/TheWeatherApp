//
//  ImageService.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import UIKit


typealias ImageRequestResult = Result<UIImage, Error>
typealias ImageServiceCompletion = (ImageRequestResult)-> ()

/// Service for fetching weather icon from the network
class ImageService {
    var networkHandler: NetworkHandler
    var fetchRequest: URLSessionTask?
    
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
    
    func cancel() {
        fetchRequest?.cancel()
    }
}

extension ImageService {
    /// Fetches the weather image  using the *WeatherAPI * *weatherImage* end point
    /// - Parameter completion: completion closure with *UIImage*  or error string
    func fetchImage(_ path: String, completion: @escaping ImageServiceCompletion) {
        fetchRequest = networkHandler.fetchData(WeatherAPI.weatherImage(path: path), completion: { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(ServiceError.noData))
                    return
                }
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(ServiceError.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
