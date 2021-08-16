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
  
  @Published var isLoading: Bool = false
  
  @Published var sortOption: SortOption = .holdings
  
  enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
  }
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    $searchText
      .combineLatest(coinDataService.$allCoins, $sortOption)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterAndSortCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map(mapAllCoinsToPortfolioCoins)
      .sink { [weak self] returnedCoins in
        guard let self = self else { return }
        self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
      }
      .store(in: &cancellables)
    
    marketDataService.$marketData
      .combineLatest($portfolioCoins)
      .map(mapGlobalMarketData)
      .sink { [weak self] returnedStats in
        self?.statistics = returnedStats
        self?.isLoading = false
      }
      .store(in: &cancellables)
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  private func filterAndSortCoins(text: String, coins: Array<CoinModel>, sort: SortOption) -> Array<CoinModel> {
    var updatedCoins = filterCoins(text: text, coins: coins)
    sortCoins(sort: sort, coins: &updatedCoins)
    return updatedCoins
  }
  
  private func sortCoins(sort: SortOption, coins: inout Array<CoinModel>) {
    switch sort {
    case .rank:
      coins.sort { $0.rank < $1.rank }
    case .rankReversed:
      coins.sort { $0.rank > $1.rank }
    case .holdings:
      coins.sort { $0.rank < $1.rank }
    case .holdingsReversed:
      coins.sort { $0.rank > $1.rank }
    case .price:
      coins.sort { $0.currentPrice > $1.currentPrice }
    case .priceReversed:
      coins.sort { $0.currentPrice < $1.currentPrice }
    }
  }
  
  private func sortPortfolioCoinsIfNeeded(coins: Array<CoinModel>) -> Array<CoinModel> {
    // holdings or reveresedHoldings
    switch sortOption {
    case .holdings:
      return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
    case .holdingsReversed:
      return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
    default:
      return coins
    }
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
  
  func reloadData() {
    isLoading = true
    coinDataService.getCoins()
    marketDataService.getMarketData()
    HapticManager.notification(type: .success)
  }
  
  private func mapAllCoinsToPortfolioCoins(allCoins: Array<CoinModel>, portfolioEntities: Array<PortfolioEntity>) -> Array<CoinModel> {
    allCoins
      .compactMap { coin -> CoinModel? in
        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
        return coin.updateHoldings(amount: entity.amount)
      }
  }
  
  private func mapGlobalMarketData(data: MarketDataModel?, portfolioCoins: Array<CoinModel>) -> Array<StatisticsModel> {
    var stats: Array<StatisticsModel> = Array()
    guard let data = data else { return stats }
    
    let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = StatisticsModel(title: "14hr Volume", value: data.volume)
    let bitCoinDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
    
    let portfolioValue = portfolioCoins.map( { $0.currentHoldingsValue } ).reduce(0, +)
    
    let previousValue = portfolioCoins.map { coin -> Double in
      let currentValue = coin.currentHoldings
      let percentChange = coin.priceChangePercentage24H ?? 0.0 / 100
      let previousValue = currentValue ?? 0.0 / (1 + percentChange)
      return previousValue
    }.reduce(0, +)
    
    let percentageChange = (portfolioValue - previousValue) / previousValue
    let portffolio = StatisticsModel(title: "Portfolio Value", value: "\(portfolioValue.asCurrencyWithTwoDecimals())", percentageChange: percentageChange)
    
    stats.append(contentsOf: [marketCap, volume, bitCoinDominance, portffolio])
    
    return stats
  }
}
