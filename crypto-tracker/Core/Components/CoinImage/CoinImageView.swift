//
//  CointImageView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import SwiftUI

struct CoinImageView: View {
  @StateObject private var vm: CoinImageViewModel
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
  }
  
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else if vm.isLoading {
        ProgressView()
      } else {
        Image(systemName: "questionmark")
      }
    }
  }
}

struct CointImageView_Previews: PreviewProvider {
  static var previews: some View {
    CoinImageView(coin: dev.coin)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
