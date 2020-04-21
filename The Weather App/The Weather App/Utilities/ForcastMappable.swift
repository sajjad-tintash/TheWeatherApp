//
//  ForcastMappable.swift
//  The Weather App
//
//  Created by Sajjad on 20/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation

/// Converts Forcast data into date wise mapping
/// Conforming types can  either give implementation or use default implementation
protocol ForcastMappable {
    func mapForcastsToDate(_ forcasts: [Forcast?]) -> [WeatherDateMap]
}

extension ForcastMappable {
    /// Converts Forcast data into a date wise mapping, each forcast is placed under its own day so that a specific day's data can be shown
    /// Final array is sorted on date so that most recent date is at top
    /// - Parameter forcasts: array of *Forcast* objects
    func mapForcastsToDate(_ forcasts: [Forcast?]) -> [WeatherDateMap] {
        let forcastDict = forcasts.reduce([Date: [Forcast]]()) { (dict, forcast) -> [Date: [Forcast]] in
            var dict = dict
            let forcastDateStr = forcast?.date?.dateStringWithoutTime()
            let date = forcastDateStr?.dateFromString()
            
            guard let unwrappedForcast = forcast, let unwrappedDate = date else {
                return dict
            }
            
            if var dateForcasts = dict[unwrappedDate]?.compactMap({$0}) {
                dateForcasts.append(unwrappedForcast)
                dict[unwrappedDate] = dateForcasts
            } else {
                dict[unwrappedDate] = [unwrappedForcast]
            }
            
            return dict
        }
        
        var dateWiseForcasts = forcastDict.compactMap { (arg) -> WeatherDateMap in
            let (key, value) = arg
            return WeatherDateMap(date: key, forcasts: value)
        }
        
        dateWiseForcasts = dateWiseForcasts.sorted(by: { $0.date < $1.date })
        return dateWiseForcasts
    }
}
