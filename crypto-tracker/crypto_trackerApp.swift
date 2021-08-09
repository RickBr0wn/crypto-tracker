//
//  crypto_trackerApp.swift
//  crypto-tracker
//
//  Created by Rick Brown on 05/08/2021.
//

import SwiftUI

@main
struct crypto_trackerApp: App {
  @StateObject private var vm = HomeViewModel()
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
      .environmentObject(vm)
    }
  }
}
