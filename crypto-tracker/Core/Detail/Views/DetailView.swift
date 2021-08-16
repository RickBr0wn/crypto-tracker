//
//  DetailView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 16/08/2021.
//

import SwiftUI

struct DetailLoadingView: View {
  @Binding var coin: CoinModel?
  
  var body: some View {
    ZStack {
      if let coin = coin {
        DetailView(coin: coin)
      }
    }
  }
}

struct DetailView: View {
  @StateObject private var vm: DetailViewModel
  
  private let columns: Array<GridItem> = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  private var spacing: CGFloat = 30.0
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        Text("")
          .frame(height: 150)
        
        overviewTitle
        overviewGrid
        Divider()
        additionalTitle
        additionalGrid
      }
      .padding()
    }
    .navigationBarTitle(vm.coin.name)
  }
}

extension DetailView {
  private var overviewTitle: some View {
    Text("Overview")
      .font(.title)
      .bold()
      .foregroundColor(.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var additionalTitle: some View {
    Text("Additional Details")
      .font(.title)
      .bold()
      .foregroundColor(.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var overviewGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: spacing,
      pinnedViews: [],
      content: {
        ForEach(vm.overviewStatistics) { stat in
          MarketStatisticsView(stat: stat)
        }
      })
  }
  
  private var additionalGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: spacing,
      pinnedViews: [],
      content: {
        ForEach(vm.additionalStatistics) { stat in
          MarketStatisticsView(stat: stat)
        }
      })
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DetailView(coin: dev.coin)
    }
  }
}
