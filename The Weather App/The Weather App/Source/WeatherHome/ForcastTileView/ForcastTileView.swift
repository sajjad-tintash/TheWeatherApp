//
//  SlotTileView.swift
//  The Weather App
//
//  Created by Sajjad on 08/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct ForcastTileView: View {
    @State var forcast: Forcast?
    
    var body: some View {
        
        VStack {
            Text(forcast?.date?.timeStringWithoutDate() ?? "TIME")
               .font(.subheadline)
               .fontWeight(.thin)
           Image(systemName: "photo")
                .resizable()
            .frame(width: 60, height: 50, alignment: .center)
            Text((forcast?.weatherParticular?.temp?.format(f: "0.2") ?? "--") + " " + Utility.getUserTempUnitSymbol())
               .font(.headline)
               .fontWeight(.thin)
        }
        .padding(.all)
        .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
        .border(Color.gray.opacity(0.5), width: 0.5)
        .cornerRadius(8)
        
    }
}

struct ForcastTileView_Previews: PreviewProvider {
    static var previews: some View {
        ForcastTileView(forcast: DummyHomeData.forcast)
    }
}
