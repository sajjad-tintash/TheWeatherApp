//
//  NetworkHandler.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation


/// For Setting network envoirenment of the app
enum NetworkEnvironment {
    case staging
    case production
    case development
}

/// Defines service response status and provides error strings for network request error
enum ServiceError: Error {
    case success
    case authenticationError
    case badRequest
    case failed
    case noData
    case unableToDecode
    case noInternet
    
    var localizedDescription: String {
        switch self {
        case .authenticationError:
            return "Authentication Error"
        case .badRequest:
            return "Bad Request"
        case .failed:
            return "Network request Failed"
        case .noData:
            return "No Data Found"
        case .unableToDecode:
            return "Decoding Error"
        case .noInternet:
            return "No Internet Connectivity."
        case .success:
            return "Success"
        }
    }
}

typealias NetworkRequestResult = Result<Data?, Error>
typealias NetworkServiceCompletion = (NetworkRequestResult)-> ()


/// Provides network request creation and routing
struct NetworkHandler {
    static let environment: NetworkEnvironment = .production
    private var router = NetworkRouter<WeatherAPI>()
}

extension NetworkHandler {
    
    /// Checks URLResponse statusCode and returns a *NetworkResponse* case depending upon status
    /// - Parameter urlResponse: URLResponse received back from URLTask
    private func parseHTTPResponse(_ urlResponse:HTTPURLResponse) -> ServiceError {
        switch urlResponse.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .authenticationError
        case 501...600:
            return .badRequest
        default:
            return .failed
        }
    }
    
    /// Sends a  request for the reuested API endpoint and returns a completion closure with Data object or error string
    /// - Parameter endPoint: Must be a type confirming EndPointType protocol
    /// - Parameter completion: returns data or error string
    @discardableResult
    func fetchData<EndPoint>(_ endPoint: EndPoint, completion: @escaping NetworkServiceCompletion) -> URLSessionTask? where EndPoint:EndPointType{
        router.request(endPoint: endPoint as! WeatherAPI) {(data, response, error) in
            self.parseURLRequestData(data: data, response: response, error: error) { result in
                completion(result)
            }
        }
    }
    
    /// Parse the URLRequest response and returns a completion closure with Data object or error string
    /// - Parameter data: Data object received in URLRequest completion closure
    /// - Parameter response: URLResponse object received in URLRequest completion closure
    /// - Parameter error: Error object received in URLRequest completion closure
    /// - Parameter completion: completion closure with Data object or error string
    private func parseURLRequestData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkServiceCompletion) {
        
        if let _ = error {
            completion(.failure(ServiceError.noInternet))
            return
        }
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            completion(.failure(ServiceError.failed))
            return
        }
        
        let networkResponse = parseHTTPResponse(httpURLResponse)
        switch networkResponse {
        case .success:
            guard let data = data else {
                completion(.failure(ServiceError.noData))
                return
            }
            completion(.success(data))
        default:
            completion(.failure(networkResponse))
        }
    }
}

