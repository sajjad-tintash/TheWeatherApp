//
//  HomeView.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var weatherData: [WeatherDateMap]
    
    var body: some View {
        List(weatherData) { item in
            DailyForcastView(forcastInfo: item)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(weatherData: DummyHomeData.weatherData)
    }
}
