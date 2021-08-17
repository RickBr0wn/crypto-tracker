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
  
  @State private var showFullDescription: Bool = false
  
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
      VStack {
        ChartView(coin: vm.coin)
          .padding(.vertical)
        
        VStack(spacing: 20) {
          overviewTitle
          overviewGrid
          Divider()
          descriptionSection
          Divider()
          additionalTitle
          additionalGrid
          linksSection
        }
        .padding()
      }
    }
    .navigationBarTitle(vm.coin.name)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) { navigationBarItemsTrailing }
    }
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
  
  private var navigationBarItemsTrailing: some View {
    HStack {
      Text(vm.coin.symbol.uppercased())
        .font(.headline)
        .foregroundColor(.theme.secondaryText)
      
      CoinImageView(coin: vm.coin)
        .frame(width: 25, height: 25)
    }
  }
  
  private var descriptionSection: some View {
    ZStack {
      if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
        VStack(alignment: .leading) {
          Text(coinDescription)
            .lineLimit(showFullDescription ? nil : 3)
            .font(.callout)
            .foregroundColor(.theme.secondaryText)
          
          Button(action: {
            withAnimation(.easeInOut) {
              showFullDescription.toggle()
            }
          }, label: {
            Text(showFullDescription ? "Show less" : "Read more..")
              .font(.caption)
              .fontWeight(.bold)
              .padding(.vertical, 4)
          })
          .accentColor(.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
  
  private var linksSection: some View {
    VStack(alignment: .leading, spacing: 20) {
      if let websiteURL = vm.websiteURL, let url = URL(string: websiteURL) {
        Link("website", destination: url)
      }
      
      if let redditURL = vm.redditURL, let url = URL(string: redditURL) {
        Link("reddit", destination: url)
      }
    }
    .accentColor(.blue)
    .frame(maxWidth: .infinity, alignment: .leading)
    .font(.headline)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DetailView(coin: dev.coin)
    }
  }
}
