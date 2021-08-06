//
//  HomeViewModel.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var allCoins: Array<CoinModel> = Array()
  @Published var portfolioCoins: Array<CoinModel> = Array()
  
  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      self.allCoins.append(DeveloperPreview.instance.coin)
      self.portfolioCoins.append(DeveloperPreview.instance.coin)
    }
  }
}
