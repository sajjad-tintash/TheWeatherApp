//
//  Router.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

/// Provides interface for network routing and defines an associated type *EndPoint* confirming to *EndPointType* protocol
protocol Router{
    
    associatedtype EndPoint: EndPointType
    
    @discardableResult
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) -> URLSessionTask?
}
