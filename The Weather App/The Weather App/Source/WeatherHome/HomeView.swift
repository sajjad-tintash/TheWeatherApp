//
//  HomeView.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State private var isOnline : Int = 1
    
    var body: some View {
        VStack() {
            Picker("", selection: $isOnline) {
                       Text("Online").tag(0).font(.title)
                       Text("Offline").tag(1).font(.title)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    ForEach(0 ..< 3) { item in
                        VStack() {
                            Text("2020-04-01").padding()
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                                        VStack() {
                                            Text("Time")
                                            Image(systemName: "photo")
                                            Text("Temperature")
                                        }
                                    }
                                }
                                Spacer()
                            }.frame(height: 100)
                        }
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
