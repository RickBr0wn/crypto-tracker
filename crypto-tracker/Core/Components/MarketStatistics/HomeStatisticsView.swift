//
//  HomeStatisticsView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 10/08/2021.
//

import SwiftUI

struct HomeStatisticsView: View {
  @Binding var showPotfolio: Bool
  
  @EnvironmentObject private var vm: HomeViewModel
  
  var body: some View {
    HStack {
      ForEach(vm.statistics) { stat in
        MarketStatisticsView(stat: stat)
          .frame(width: UIScreen.main.bounds.width / 3)
      }
    }
    .frame(width: UIScreen.main.bounds.width, alignment: showPotfolio ? .trailing : .leading)
  }
}

struct HomeStatisticsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeStatisticsView(showPotfolio: .constant(false))
      .environmentObject(dev.homeVM)
  }
}
