//
//  ChartView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 17/08/2021.
//

import SwiftUI

struct ChartView: View {
  private let data: Array<Double>
  
  private let maxY: Double
  private let minY: Double
  
  private let lineColor: Color
  
  private let startingDate: Date
  private let endingDate: Date
  
  @State private var percentage: CGFloat = 0.0
  
  init(coin: CoinModel) {
    self.data = coin.sparklineIn7D?.price ?? Array()
    self.maxY = data.max() ?? 0
    self.minY = data.min() ?? 0
    
    let priceChange = (data.last ?? 0) - (data.first ?? 0)
    self.lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
    
    self.endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
    // This date should be 7 days before the the ending date
    /*
     -7 days * 24 hours * 60 minutes * 60 seconds
     */
    self.startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
  }
  
  var body: some View {
    VStack {
      chartView
        .frame(height: 200)
        .background(chartBackground)
        .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
      
      chartDateLabels.padding(.horizontal, 4)
    }
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        withAnimation(.linear(duration: 2.0)) {
          percentage = 1.0
        }
      }
    }
  }
}

extension ChartView {
  private var chartView: some View {
    GeometryReader { geometryProxy in
      Path { path in
        for index in data.indices {
          /*
           EG:
           Screen width: 300px (navigationBarItemsTrailing)
           Number of items: 100 (data.count)
           300 / 100 = 3 : Each item has 3
           Multiply by the index + 1
           
           1 * 3 = 3
           2 * 3 = 6
           3 * 3 = 9
           ...
           100 * 3 = 300
           
           This allows the chart to arrange the x axis on its own.
           */
          let xPosition = geometryProxy.size.width / CGFloat(data.count) * CGFloat(index + 1)
          
          /*
           EG:
           Highest Price: £60,000 (maxY)
           Lowest Price: £50,000 (minY)
           60,000 - 50,000 = 10,000 (yAxis)
           First price within that range: £52,000 (data[index])
           52,000 - 50,000 = 2,000 (data[index] - minY)
           2,000 / 10,000 = 0.2 (the remainder / the yAxis)
           The line should be drawn 20% from the bottom of the chart
           */
          let yAxis = maxY - minY
          let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometryProxy.size.height
          
          // At the start (index 0) set the 'path' to position 0, 0 (top left corner of the screen
          if index == 0 {
            path.move(to: CGPoint(x: xPosition, y: yPosition))
          }
          path.addLine(to: CGPoint(x: xPosition, y: yPosition))
        }
      }
      .trim(from: 0.0, to: percentage)
      .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
      .shadow(color: lineColor, radius: 10, x: 0.0, y: 10.0)
      .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20.0)
      .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30.0)
      .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40.0)
    }
  }
  
  private var chartBackground: some View {
    VStack {
      Divider()
      Spacer()
      Divider()
      Spacer()
      Divider()
    }
  }
  
  private var chartYAxis: some View {
    VStack {
      Text(maxY.formattedWithAbbreviations())
      Spacer()
      Text(((maxY + minY) / 2).formattedWithAbbreviations())
      Spacer()
      Text(minY.formattedWithAbbreviations())
    }
  }
  
  private var chartDateLabels: some View {
    HStack {
      Text(startingDate.asShortDateString())
      Spacer()
      Text(endingDate.asShortDateString())
    }
  }
}

struct ChartView_Previews: PreviewProvider {
  static var previews: some View {
    ChartView(coin: dev.coin)
  }
}
