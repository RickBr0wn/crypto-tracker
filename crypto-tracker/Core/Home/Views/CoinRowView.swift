//
//  CoinRowView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import SwiftUI

struct CoinRowView: View {
  let coin: CoinModel
  let showHoldingsColumn: Bool
  
  var body: some View {
    HStack(spacing: 0) {
      leftColumn
      Spacer()
      if showHoldingsColumn { centerColumn }
      rightColumn
    }
    .font(.subheadline)
    .background(Color.theme.background.opacity(0.01))
  }
}

extension CoinRowView {
  private var leftColumn: some View {
    HStack(spacing: 0) {
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .frame(minWidth: 30)
      
      CoinImageView(coin: coin)
        .frame(width: 30, height: 30)
      
      Text(coin.symbol.uppercased())
        .font(.headline)
        .padding(.leading, 6)
        .foregroundColor(.theme.accent)
      
    }
  }
  
  private var centerColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyWithTwoDecimals())
        .bold()
      
      Text((coin.currentHoldings ?? 0).asNumberString())
    }
    .foregroundColor(.theme.accent)
  }
  
  private var rightColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentPrice.asCurrencyWithSixDecimals())
        .bold()
        .foregroundColor(.theme.accent)
      
      Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
        .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? .theme.green : .theme.red)
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}

struct CoinRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CoinRowView(coin: dev.coin, showHoldingsColumn: true)
        .previewLayout(.sizeThatFits)
      
      CoinRowView(coin: dev.coin, showHoldingsColumn: false)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
    .padding()
  }
}
