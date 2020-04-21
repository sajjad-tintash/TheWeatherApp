//
//  NetworkReachability.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import SystemConfiguration

/// Checks internet connectivity status through out the life cycle of the app
class NetworkReachability {
    
    static var shared = NetworkReachability()
    
    var isConnectedToNetwork: Bool = false
    private var requestCompletion: ((Bool)->())?
    
    /// priavte init so that there's only one object of *NetworkReachability* accessable via *shared* staticvaribale
    private init(){}
    
    /// Checks if connected to internet or not
    func checkNetworkConnection(result: @escaping ((Bool)->())) {
        guard let url = URL(string: "http://google.com/") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        let session = URLSession.shared
        requestCompletion = result
        session.dataTask(with: request, completionHandler: {(data, response, error) in
            self.handleRequestResponse(response: response as? HTTPURLResponse)
        }).resume()
    }
    
    func handleRequestResponse(response: HTTPURLResponse?) {
        guard let httpResponse = response else {
            requestCompletion?(false)
            return
        }
        let result = httpResponse.statusCode == 200
        isConnectedToNetwork = result
        requestCompletion?(result)
    }
}
