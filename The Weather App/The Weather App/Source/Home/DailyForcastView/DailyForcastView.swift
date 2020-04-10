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

struct DailyForcastView: View {

    @ObservedObject private(set) var viewModel: DailyForcastViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.model.date.dateStringWithoutTime())
                .font(.subheadline)
                .fontWeight(.thin)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.model.forcasts) { item in
                        ForcastTileView(viewModel: ForcastTileViewModel(model: item))
                    }
                }
                .padding(.all, 5)
            }.id(UUID().uuidString)
        }
    }
}

struct DailyForcastView_Previews: PreviewProvider {
    static var previews: some View {
        DailyForcastView(viewModel: DailyForcastViewModel(model: DummyHomeData.weatherDataForOneDay))
    }
}
