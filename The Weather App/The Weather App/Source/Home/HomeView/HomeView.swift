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
        ZStack {
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
                        HStack {
                            Image(systemName: "location").foregroundColor(.gray)
                            TextField("Search ...", text: $viewModel.searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding([.leading, .trailing, .top])
                        if !viewModel.filteredCities.isEmpty {
                            ScrollView(.vertical) {
                                ForEach(viewModel.filteredCities) { city in
                                    Button(action: {
                                        self.viewModel.selectCity(city)
                                    }, label: {
                                        HStack {
                                            Text(city.fullName ?? "")
                                                .fontWeight(.light)
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                    })
                                    Rectangle()
                                        .fill(Color.white).opacity(0.3)
                                    .frame(height: 2, alignment: .bottom)
                                    .padding(.horizontal, 40)
                                }
                                .padding(.top)
                                .animation(.spring())
                            }
                            .background(RoundedCornersView(color: .gray,
                                                           tl: 0.0,
                                                           tr: 0.0,
                                                           bl: 10,
                                                           br: 10).opacity(0.3))
                            .padding(.leading, 40)
                            .padding(.trailing, 20)
                        }
                    }
                }
                Group {
                    List(viewModel.model.weatherDateMap) { item in
                        DailyForcastView(viewModel: DailyForcastViewModel(model: item))
                        Spacer()
                    }.id(UUID())
                }
            }
            if viewModel.isLoadingCity {
                ActivityIndicator(isAnimating: $viewModel.isLoadingCity, style: .large, color: .darkGray)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .opacity(0.5)
                        .frame(width: 100, height: 100))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(model: DummyHomeData.cityWeatherModel, mode: .offline))
    }
}
