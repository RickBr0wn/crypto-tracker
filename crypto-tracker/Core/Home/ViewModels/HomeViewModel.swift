//
//  HomeViewModel.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var statistics: Array<StatisticsModel> = Array()
  
  @Published var allCoins: Array<CoinModel> = Array()
  @Published var portfolioCoins: Array<CoinModel> = Array()
  @Published var searchText: String = ""
  
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    $searchText
      .combineLatest(coinDataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    marketDataService.$marketData
      .map(mapGlobalMarketData)
      .sink { [weak self] returnedStats in
        self?.statistics = returnedStats
      }
      .store(in: &cancellables)

    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map { coinModels, portfolioEntities -> Array<CoinModel> in
        coinModels.compactMap { coin -> CoinModel? in
          guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
          return coin.updateHoldings(amount: entity.amount)
        }
      }
      .sink { [weak self] returnedCoins in
        self?.portfolioCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  private func filterCoins(text: String, coins: Array<CoinModel>) -> Array<CoinModel> {
    guard !text.isEmpty else { return coins }
    
    let lowerCasedText = text.lowercased()
    
    return coins.filter { coin in
      return coin.name.lowercased().contains(lowerCasedText)
        || coin.symbol.lowercased().contains(lowerCasedText)
        || coin.id.lowercased().contains(lowerCasedText)
    }
  }
  
  private func mapGlobalMarketData(data: MarketDataModel?) -> Array<StatisticsModel> {
    var stats: Array<StatisticsModel> = Array()
    guard let data = data else { return stats }
    
    let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = StatisticsModel(title: "14hr Volume", value: data.volume)
    let bitCoinDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
    let portffolio = StatisticsModel(title: "Portfolio Value", value: "£0.10", percentageChange: 0)
    stats.append(contentsOf: [marketCap, volume, bitCoinDominance, portffolio])
    
    return stats
  }
}
