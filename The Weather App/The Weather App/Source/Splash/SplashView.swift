//
//  SplashView.swift
//  The Weather App
//
//  Created by Sajjad on 08/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI
import Combine

struct SplashView: View {

    @ObservedObject private var viewModel = SplashViewModel()
    
    let gradientColors = Gradient(colors: [
        Color.green.opacity(0.6),
        Color.blue.opacity(0.8)
    ])
    
    var body: some View {
        Group {
            if self.viewModel.shouldNavigateToHome {
                HomeView(weatherData: self.viewModel.offlineData)
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.6666666667, green: 0.8509803922, blue: 0.9137254902, alpha: 1)))
                        .edgesIgnoringSafeArea(.top)
                    VStack(alignment: .center) {
                        Image("logo")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            //.colorMultiply(Color(#colorLiteral(red: 0.1658988893, green: 0.2430971265, blue: 0.2193600237, alpha: 1)))
                        ActivityIndicator(isAnimating: .constant(true),
                                          style: .large,
                                          color: .white)
                        Text("Loading...")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.regular)
                    }
                    .padding(.bottom, 50)
                    .onAppear {
                        self.viewModel.fetch()
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
