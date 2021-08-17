//
//  SettingsView.swift
//  crypto-tracker
//
//  Created by Rick Brown on 17/08/2021.
//

import SwiftUI

struct SettingsView: View {
  let defaultURL = URL(string: "https://www.google.com")!
  let gitHub = URL(string: "https://github.com/RickBr0wn")!
  let buyMeACoffee = URL(string: "https://www.buymeacoffee.com/RickBrown")!
  let coinGeckoAPI = URL(string: "https://www.coingecko.com/en/api/documentation")!
  let personalWebsite = URL(string: "https:www.rickbrown.co.uk")!
  
  var body: some View {
    NavigationView {
      List {
        personalSection
        coinGeckoSection
        developerSection
        applicationSection
      }
      .font(.headline)
      .accentColor(.blue)
      .listStyle(GroupedListStyle())
      .navigationBarTitle("Settings")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          XMarkButton()
        }
      }
    }
  }
}

extension SettingsView {
  private var personalSection: some View {
    Section(header: Text("Crypto Tracker")) {
      VStack(alignment: .leading) {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20.0))
        
        Text("This app was created using SwiftUI, MVVM architecture, Combine & Core Data.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
          .padding(.vertical)
      }
      Link("Follow me on gitHub 👨🏻‍💻", destination: gitHub)
      Link("Support me with coffee! ☕️", destination: buyMeACoffee)
    }
  }
  
  private var coinGeckoSection: some View {
    Section(header: Text("Coin Gecko")) {
      VStack(alignment: .leading) {
        Image("coingecko")
          .resizable()
          .frame(height: 100)
          .scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 20.0))
        
        Text("The crypto currency data used in this app is distrbuted from a free API from coinGecko. Prices may be subject to a small time delay.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
          .padding(.vertical)
      }
      Link("CoinGecko 🦎", destination: coinGeckoAPI)
    }
  }
  
  private var developerSection: some View {
    Section(header: Text("Developer")) {
      VStack(alignment: .leading) {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
          .scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 20.0))
        
        Text("This app was developed by Rick Brown. The project beneifts from multi-threading, subscribers/publishers and data persistance.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
          .padding(.vertical)
      }
      Link("Website 🖥", destination: personalWebsite)
    }
  }
  
  private var applicationSection: some View {
    Section(header: Text("Application")) {
      Link("Terms of Service", destination: defaultURL)
      Link("Privacy Policy", destination: defaultURL)
      Link("Company Website", destination: defaultURL)
      Link("Learn More", destination: defaultURL)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
