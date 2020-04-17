//
//  ImageCache.swift
//  The Weather App
//
//  Created by Sajjad on 17/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {

    var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    static var shared = ImageCache()
}
