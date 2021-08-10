//
//  HomeViewModel.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var statistics: Array<StatisticsModel> = [
    StatisticsModel(title: "Title", value: "Value", percentageChange: 5.0),
    StatisticsModel(title: "Title", value: "Value", percentageChange: 0),
    StatisticsModel(title: "Title", value: "Value", percentageChange: 0),
    StatisticsModel(title: "Title", value: "Value", percentageChange: -5.0),
  ]
  
  @Published var allCoins: Array<CoinModel> = Array()
  @Published var portfolioCoins: Array<CoinModel> = Array()
  @Published var searchText: String = ""
  
  private let dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    $searchText
      .combineLatest(dataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
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
}
