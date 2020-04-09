//
//  DailySlotsView.swift
//  The Weather App
//
//  Created by Sajjad on 08/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct WeatherDateMap: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let forcasts: [Forcast]
}

struct DailySlotsView: View {
    @State var forcastInfo: WeatherDateMap
    
    var body: some View {
        VStack {
            Text(forcastInfo.date.dateStringWithoutTime())
                .font(.subheadline)
                .fontWeight(.thin)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(forcastInfo.forcasts) { index in
                        SlotTileView(forcast: index)
                    }
                }
            }.id(UUID().uuidString)
        }
    }
}

struct DailySlotsView_Previews: PreviewProvider {
    static var previews: some View {
        DailySlotsView(forcastInfo: DummyHomeData.weatherDataForOneDay)
    }
}
