//
//  SlotTileView.swift
//  The Weather App
//
//  Created by Sajjad on 08/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct ForcastTileView: View {
    
    @ObservedObject private(set) var viewModel: ForcastTileViewModel
    
    var body: some View {
        
        VStack {
            Text(viewModel.model.date?.timeStringWithoutDate() ?? "TIME")
               .font(.subheadline)
               .fontWeight(.thin)
            Image(uiImage: viewModel.image ?? UIImage())
                .resizable()
            .frame(width: 60, height: 50, alignment: .center)
            Text((viewModel.model.weatherParticular?.temp?.format(f: "0.2") ?? "--") + " " + Utility.getUserTempUnitSymbol())
               .font(.headline)
               .fontWeight(.thin)
            Text(viewModel.model.weather?.first??.main ?? "MAIN")
               .font(.caption)
               .fontWeight(.thin)
            
        }
        .padding(.all)
        .background(Colors.themeColor)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .shadow(radius: 4)
        .onAppear {
            self.viewModel.load()
        }
        .onDisappear {
            self.viewModel.cancel()
        }
    }
}

struct ForcastTileView_Previews: PreviewProvider {
    static var previews: some View {
        ForcastTileView(viewModel: ForcastTileViewModel(model: DummyHomeData.forcast))
    }
}
