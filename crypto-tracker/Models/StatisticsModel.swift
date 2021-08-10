//
//  StatisticsModel.swift
//  crypto-tracker
//
//  Created by Rick Brown on 10/08/2021.
//

import Foundation

struct StatisticsModel: Identifiable {
  let id = UUID().uuidString
  let title: String
  let value: String
  let percentageChange: Double?
  
  init(title: String, value: String, percentageChange: Double? = nil) {
    self.title = title
    self.value = value
    self.percentageChange = percentageChange
  }
}

let newModel = StatisticsModel(title: "", value: "")
