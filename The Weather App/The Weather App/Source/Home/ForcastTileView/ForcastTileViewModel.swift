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
    @Published private(set) var image: UIImage! = UIImage(systemName: "photo")
    
    fileprivate var imageService: ImageService = ImageService(NetworkHandler())
    
    init(model: Forcast) {
        self.model = model
    }
    
    func load() {
        guard let path = model.weather?.first??.icon else {
            return
        }
        imageService.fetchImage(path) { (result) in
            switch result {
            case .success(let image):
                self.setImage(image)
            case .failure(_):
                break
            }
        }
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
    
    func cancel(){
        imageService.cancel()
    }
}
