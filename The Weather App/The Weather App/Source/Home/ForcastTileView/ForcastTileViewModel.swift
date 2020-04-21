//
//  ForcastTileViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import UIKit

/// Single time slot forcast view's view model
class ForcastTileViewModel: ObservableObject {
    
    /// Holds forcast information
    private(set) var model: Forcast
    /// Publised property, set when image is downloaded/fetched from cache
    @Published private(set) var image: UIImage = UIImage()
    
    /// Service that download image
    fileprivate var imageService: ImageService = ImageService(NetworkHandler())
    
    init(model: Forcast) {
        self.model = model
        load()
    }
    
    /// Loads image
    func load() {
        guard !setCachedImage() else {
            return
        }
        guard let path = model.weather?.first??.icon else {
            return
        }
        imageService.fetchImage(path) { (result) in
            switch result {
            case .success(let image):
                self.setDownloadedImage(image)
            case .failure(_):
                break
            }
        }
    }
    
    /// Cancel service request
    func cancel(){
        imageService.cancel()
    }
}

extension ForcastTileViewModel {
    /// Sets image to property from cache
    fileprivate func setCachedImage() -> Bool {
        let cache = ImageCache.shared
        guard let path = model.weather?.first??.icon else {
            return false
        }
        guard let cachedImage = cache.get(forKey: path) else {
            return false
        }
        setImage(cachedImage)
        return true
    }
    
    /// Sets downloaded image and caches it
    /// - Parameter image: downloaded image
    fileprivate func setDownloadedImage(_ image: UIImage) {
        cacheImage(image)
        setImage(image)
    }
    
    fileprivate func setImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
    
    fileprivate func cacheImage(_ image: UIImage) {
        let cache = ImageCache.shared
        guard let path = model.weather?.first??.icon else {
            return
        }
        cache.set(forKey: path, image: image)
    }
}
