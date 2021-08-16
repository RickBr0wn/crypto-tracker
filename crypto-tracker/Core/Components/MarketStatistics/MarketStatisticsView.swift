//
//  MarketStatisticsView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 10/08/2021.
//

import SwiftUI

struct MarketStatisticsView: View {
  let stat: StatisticsModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(stat.title)
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
      
      Text(stat.value)
        .font(.headline)
        .foregroundColor(.theme.accent)
      
      HStack(spacing: 4) {
        Image(systemName: "triangle.fill")
          .font(.caption2)
          .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
        
        Text(stat.percentageChange?.asPercentString() ?? "")
          .font(.caption)
          .bold()
      }
      .foregroundColor((stat.percentageChange ?? 0) >= 0 ? .theme.green : .theme.red)
      .opacity(stat.percentageChange == nil ? 0 : 1.0)
    }
  }
}

struct MarketStatisticsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MarketStatisticsView(stat: dev.stat)
        .previewLayout(.sizeThatFits)
        .padding()
      
      MarketStatisticsView(stat: dev.stat2)
        .previewLayout(.sizeThatFits)
        .padding()
      
      MarketStatisticsView(stat: dev.stat3)
        .previewLayout(.sizeThatFits)
        .padding()
    }
  }
}
