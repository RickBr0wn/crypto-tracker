//
//  CoinDataService.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import Foundation
import Combine

class CoinDataService {
  @Published var allCoins: Array<CoinModel> = Array()
  
  var coinSubscription: AnyCancellable?
  
  init() {
    getCoins()
  }
  
  private func getCoins() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    
    coinSubscription = NetworkingManager.download(url: url)
      .decode(type: Array<CoinModel>.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
        self?.coinSubscription?.cancel()
      })
  }
  
}
