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
    
    init(model: Forcast) {
        self.model = model
    }
    
    func load() {
    }
    
    func cancel(){
        
    }
    
}
