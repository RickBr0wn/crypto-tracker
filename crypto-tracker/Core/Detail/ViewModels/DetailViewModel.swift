//
//  DetailViewModel.swift
//  crypto-tracker
//
//  Created by Rick Brown on 16/08/2021.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
  private let coinDetailService: CoinDetailDataService
  @Published var coin: CoinModel
  
  @Published var overviewStatistics: Array<StatisticsModel> = Array()
  @Published var additionalStatistics: Array<StatisticsModel> = Array()
  
  @Published var coinDescription: String? = nil
  @Published var websiteURL: String? = nil
  @Published var redditURL: String? = nil
  
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coinDetailService = CoinDetailDataService(coin: coin )
    self.coin = coin
    self.addSubscribers()
  }
  
  private func addSubscribers() {
    coinDetailService.$coinDetails
      .combineLatest($coin)
      .map(mapDataToStatistics)
      .sink { [weak self] returnedArrays in
        self?.overviewStatistics = returnedArrays.overview
        self?.additionalStatistics = returnedArrays.additional
      }
      .store(in: &cancellables)
    
    coinDetailService.$coinDetails
      .sink { [weak self] returnedCoinDetails in
        self?.coinDescription = returnedCoinDetails?.readableDescription
        self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
        self?.redditURL = returnedCoinDetails?.links?.subredditURL
      }
      .store(in: &cancellables)
  }
  
  private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: Array<StatisticsModel>, additional: Array<StatisticsModel>) {
    let overviewArray = createOverviewArray(coinModel: coinModel)
    let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
    
    return (overviewArray, additionalArray)
  }
  
  private func createOverviewArray(coinModel: CoinModel) -> Array<StatisticsModel> {
    let price = coinModel.currentPrice.asCurrencyWithTwoDecimals()
    let pricePercentChange = coinModel.priceChangePercentage24H
    let priceStat = StatisticsModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
    
    let marketCap = "£" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
    let marketCapPercentChange = coinModel.marketCapChangePercentage24H
    let marketCapStat = StatisticsModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
    
    let rank = "\(coinModel.rank)"
    let rankStat = StatisticsModel(title: "Rank", value: rank)
    
    let volume = "£" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
    let volumeStat = StatisticsModel(title: "Volume", value: volume)
    
    let overviewArray: Array<StatisticsModel> = [priceStat, marketCapStat, rankStat, volumeStat]
    
    return overviewArray
  }
  
  private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> Array<StatisticsModel> {
    let high = coinModel.high24H?.asCurrencyWithSixDecimals() ?? "n/a"
    let highStat = StatisticsModel(title: "24hr High", value: high)
    
    let low = coinModel.low24H?.asCurrencyWithSixDecimals() ?? "n/a"
    let lowStat = StatisticsModel(title: "24hr Low", value: low)
    
    let priceChange = coinModel.priceChange24H?.asCurrencyWithSixDecimals() ?? "n/a"
    let pricePercentChange = coinModel.priceChangePercentage24H
    let priceChangeStat = StatisticsModel(title: "24hr Price CHange", value: priceChange, percentageChange: pricePercentChange)
    
    let marketCapChange = "£" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
    let marketCapPercentChange = coinModel.marketCapChange24H
    let marketCapChangeStat = StatisticsModel(title: "24hr MarketCap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
    
    let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
    let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
    let blockTimeStat = StatisticsModel(title: "Block Time", value: blockTimeString)
    
    let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
    let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
    
    let additionalArray: Array<StatisticsModel> = [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingStat]
    
    return additionalArray
  }
}
