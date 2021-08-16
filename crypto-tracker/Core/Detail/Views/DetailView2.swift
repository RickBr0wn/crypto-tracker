//
//  DetailView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 16/08/2021.
//

import SwiftUI

struct DetailLoadingView2: View {
  @Binding var coin: CoinModel?
  
  var body: some View {
    ZStack {
      if let coin = coin {
        DetailView2(coin: coin)
      }
    }
  }
}

struct DetailView2: View {
  @StateObject var vm : DetailViewModel
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        Text("")
          .frame(height: 150)

        Text("OverView")
          .font(.title)
          .bold()
          .foregroundColor(.theme.accent)
          .frame(maxWidth: .infinity, alignment: .leading)

        Divider()
      }
      .padding()
    }
    .navigationBarTitle(vm.coin.name)
  }
}

struct DetailView2_Previews: PreviewProvider {
  static var previews: some View {
      DetailView2(coin: dev.coin)
  }
}
