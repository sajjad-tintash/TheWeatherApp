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
            Group {
                HStack {
                    if viewModel.model.hasCityName {                        
                        Image(systemName: "location")
                            .resizable()
                            .frame(width: 12, height: 12, alignment: .trailing)
                            .padding(.leading)
                    }
                    Text(viewModel.model.cityFullName)
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
            }
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
                if viewModel.mode == .live {
                    TextField("Search ...", text: $viewModel.searchText)
                        .padding(.all)
                }
            }
            Group {
                List(viewModel.model.weatherDateMap) { item in
                    DailyForcastView(viewModel: DailyForcastViewModel(model: item))
                    Spacer()
                }.id(UUID())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(model: DummyHomeData.cityWeatherModel, mode: .offline))
    }
}
