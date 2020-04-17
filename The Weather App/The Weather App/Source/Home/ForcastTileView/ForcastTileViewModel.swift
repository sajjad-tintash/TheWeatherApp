//
//  ForcastTileViewModel.swift
//  The Weather App
//
//  Created by Sajjad on 10/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import UIKit

class ForcastTileViewModel: ObservableObject {
    
    @Published private(set) var model: Forcast
    @Published private(set) var image: UIImage = UIImage()
    
    fileprivate var imageService: ImageService = ImageService(NetworkHandler())
    
    init(model: Forcast) {
        self.model = model
        load()
    }
    
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
    
    func cancel(){
        imageService.cancel()
    }
}

extension ForcastTileViewModel {
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
