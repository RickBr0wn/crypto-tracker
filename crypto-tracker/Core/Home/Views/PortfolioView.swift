//
//  PortfolioView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 16/08/2021.
//

import SwiftUI

struct PortfolioView: View {
  @EnvironmentObject private var vm: HomeViewModel
  @State private var selectedCoin: CoinModel? = nil
  @State private var quantityText: String = ""
  @State private var showCheckMark: Bool = false
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          SearchBarView(searchText: $vm.searchText)
          
          coinLogoList
          
          if selectedCoin != nil { portfolioInputSection }
        }
      }
      .navigationTitle("Edit Portfolio")
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          XMarkButton()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          trailingNavBarButtons
        }
      })
    }
  }
}

extension PortfolioView {
  private var coinLogoList: some View {
    ScrollView(.horizontal, showsIndicators: false, content: {
      LazyHStack(spacing: 10) {
        ForEach(vm.allCoins) { coin in
          CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .onTapGesture {
              withAnimation(.easeIn) {
                selectedCoin = coin
              }
            }
            .background(
              RoundedRectangle(cornerRadius: 10.0)
                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
            )
        }
      }
      .frame(height: 120)
      .padding(.leading)
    })
  }
  
  private func getCurrentValue() -> Double {
    if let quantity = Double(quantityText) {
      return quantity * (selectedCoin?.currentPrice ?? 0.0)
    }
    return 0.0
  }
  
  private var portfolioInputSection: some View {
    VStack(spacing: 20) {
      HStack {
        Text("Current price of: \(selectedCoin?.symbol.uppercased() ?? "")")
        Spacer()
        Text(selectedCoin?.currentPrice.asCurrencyWithTwoDecimals() ?? "")
      }
      
      Divider()
      
      HStack {
        Text("Amount holding:")
        Spacer()
        TextField("Eg: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }
      
      Divider()
      
      HStack {
        Text("Current Value")
        Spacer()
        Text(getCurrentValue().asCurrencyWithTwoDecimals())
      }
    }
    .animation(.none)
    .padding()
    .font(.headline)
  }
  
  private var trailingNavBarButtons: some View {
    HStack(spacing: 10) {
      Image(systemName: "checkmark")
        .opacity(showCheckMark ? 1.0 : 0.0)
      Button(action: {
        saveButtonPressed()
      }, label: {
        Text("save".uppercased())
      })
      .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
    }
    .font(.headline)
  }
  
  private func saveButtonPressed() {
    guard let coin = selectedCoin else { return }
    // save to portfolio
    
    withAnimation(.easeIn) {
      showCheckMark = true
      removeSelectedCoin()
    }
    
    // hide keyboard
    UIApplication.shared.endEditing()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      withAnimation(.easeOut) {
        showCheckMark = false
      }
    }
  }
  
  private func removeSelectedCoin() {
    selectedCoin = nil
    vm.searchText = ""
  }
}

struct PortfolioView_Previews: PreviewProvider {
  static var previews: some View {
    PortfolioView()
      .environmentObject(dev.homeVM)
  }
}
