//
//  HomeView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 05/08/2021.
//

import SwiftUI

struct HomeView: View {
  @State private var showPortfolio: Bool = false
  
  var body: some View {
    ZStack {
      // MARK: background color layer
      Color.theme.background
        .ignoresSafeArea()
      
      // MARK: content layer
      VStack {
        homeHeader
        
        Spacer(minLength: 0)
      }
    }
  }
}

extension HomeView {
  private var homeHeader: some View {
    HStack {
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
        .animation(.none)
        .background(CircleButtonAnimationView(animate: $showPortfolio))
      
      Spacer()
      
      Text(showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(.theme.accent)
        .animation(.none)
      
      Spacer()
      
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
        .navigationBarHidden(true)
    }
  }
}
