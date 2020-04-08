//
//  SplashView.swift
//  The Weather App
//
//  Created by Sajjad on 08/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    let homeView = HomeView(weatherData: DummyHomeData.weatherData)
    
    let gradientColors = Gradient(colors: [
        Color.green.opacity(0.6),
        Color.blue.opacity(0.8)
    ])
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(RadialGradient(gradient: gradientColors,
                                         center: .center,
                                         startRadius: 50,
                                         endRadius: 500))
                    .edgesIgnoringSafeArea(.top)
                VStack(alignment: .center) {
                    Image("logo")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    ActivityIndicator(isAnimating: .constant(true),
                                      style: .large,
                                      color: .white)
                    Text("Loading...")
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.regular)
                    NavigationLink(destination: homeView, isActive: $isActive, label: { EmptyView( )})
                }
                .padding(.bottom, 100.0)
            }.onAppear {
                self.goToHomeScreen(withDelay: 2)
            }
        }
    }
    
    func goToHomeScreen(withDelay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(withDelay)) {
            self.isActive = true
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
