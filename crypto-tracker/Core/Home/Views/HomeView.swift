//
//  HomeView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 05/08/2021.
//

import SwiftUI

struct HomeView: View {
  @State private var showPortfolio: Bool = false
  @EnvironmentObject private var vm: HomeViewModel
  
  @State private var showPortfolioView: Bool = false
  
  var body: some View {
    ZStack {
      // MARK: background color layer
      Color.theme.background
        .ignoresSafeArea()
        .sheet(isPresented: $showPortfolioView, content: {
          PortfolioView()
            .environmentObject(vm)
        })
       
      // MARK: content layer
      VStack {
        homeHeader
        
        HomeStatisticsView(showPotfolio: $showPortfolio)
        
        SearchBarView(searchText: $vm.searchText)
        
        columnTitles
        if !showPortfolio {
          allCoinsList
          .transition(.move(edge: .leading))
        }
        if showPortfolio {
          portfolioCoinsList
            .transition(.move(edge: .trailing))
        }
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
        .onTapGesture {
          if showPortfolio {
            showPortfolioView.toggle()
          }
        }
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
  
  private var allCoinsList: some View {
    List {
      ForEach(vm.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var portfolioCoinsList: some View {
    List {
      ForEach(vm.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var columnTitles: some View {
    HStack {
      Text("Coin")
      Spacer()
      if showPortfolio {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
    .padding(.horizontal)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
        .navigationBarHidden(true)
    }
    .environmentObject(dev.homeVM)
  }
}
