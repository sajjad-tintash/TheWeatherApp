//
//  DailySlotsView.swift
//  The Weather App
//
//  Created by Sajjad on 08/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct WeatherDataMap {
    let date: Date
    let forcasts: [Forcast?]
}

struct DailySlotsView: View {
    @State var forcastInfo: WeatherDataMap
    
    var body: some View {
        VStack {
            Text(forcastInfo.date.dateStringWithoutTime())
                .font(.subheadline)
                .fontWeight(.thin)
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    ForEach(0 ..< forcastInfo.forcasts.count) { index in
                        SlotTileView(forcast: self.forcastInfo.forcasts[index])
                    }
                }
            }
        }
    }
}

struct DailySlotsView_Previews: PreviewProvider {
    static var previews: some View {
        DailySlotsView(forcastInfo: DummyHomeData.weatherDataForOneDay)
    }
}
