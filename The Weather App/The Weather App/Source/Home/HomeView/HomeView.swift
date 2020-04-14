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
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "location")
                    .resizable()
                    .frame(width: 12, height: 12, alignment: .trailing)
                    .padding(.leading)
                Text((viewModel.model.city?.name ?? "") + ((viewModel.model.city?.country == nil) ? "" : ", \(viewModel.model.city?.country ?? "")"))
                    .font(.headline)
                    .fontWeight(.light)
                Spacer()
                Circle()
                    .frame(width: 8, height: 8, alignment: .trailing)
                    .foregroundColor(viewModel.mode == .offline ? .red : .green)
                Text(viewModel.mode.text)
                    .font(.headline)
                    .fontWeight(.light)
                    .padding(.trailing)
            }
            .padding(.vertical)
            Group {
                Picker(selection: $viewModel.mode, label: Text("")) {
                    Text("Live")
                        .fontWeight(.light)
                        .tag(AppMode.live)
                    Text("Offline")
                        .fontWeight(.light)
                        .tag(AppMode.offline)
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Search ...", text: $viewModel.searchText)
                    .padding(.all)
            }
            List(viewModel.model.weatherDateMap) { item in
                DailyForcastView(viewModel: DailyForcastViewModel(model: item))
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(model: DummyHomeData.cityWeatherModel))
    }
}
