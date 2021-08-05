//
//  Color.swift
//  crypto-tracker
//
//  Created by Rick Brown on 05/08/2021.
//

import Foundation
import SwiftUI

extension Color {
  static let theme = ColorTheme()
}

struct ColorTheme {
  let accent = Color("AccentColor")
  let background = Color("backgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}
