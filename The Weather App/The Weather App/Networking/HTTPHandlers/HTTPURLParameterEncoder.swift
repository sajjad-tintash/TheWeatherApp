//
//  HTTPURLParameterEncoder.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Provides *URL* query string parameter encoder for the *URLRequest*
enum HTTPURLParameterEncoder: HTTPParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, httpParameters: HTTPParameters) throws{
        
        guard let urlToEcode = urlRequest.url else { throw EncodingError.encodeURLMissing}

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }

        guard var urlComponents = URLComponents(url: urlToEcode, resolvingAgainstBaseURL: false), !httpParameters.isEmpty else { return }
        
        urlComponents.queryItems = [URLQueryItem]()
        for (key,value) in httpParameters {
            let item = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            urlComponents.queryItems?.append(item)
        }
        urlRequest.url = urlComponents.url
    }
}
