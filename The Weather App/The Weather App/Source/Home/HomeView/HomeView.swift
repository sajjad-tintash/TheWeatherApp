//
//  HomeView.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel
    
    var body: some View {
        List(viewModel.model) { item in
            DailyForcastView(viewModel: DailyForcastViewModel(model: item))
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(model: DummyHomeData.weatherData))
    }
}
