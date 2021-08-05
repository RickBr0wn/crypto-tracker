//
//  crypto_trackerApp.swift
//  crypto-tracker
//
//  Created by Rick Brown on 05/08/2021.
//

import SwiftUI

@main
struct crypto_trackerApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
    }
  }
}
