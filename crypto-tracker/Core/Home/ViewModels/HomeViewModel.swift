//
//  HomeViewModel.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var allCoins: Array<CoinModel> = Array()
  @Published var portfolioCoins: Array<CoinModel> = Array()
  @Published var searchText: String = ""
  
  private let dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    dataService.$allCoins
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
}
