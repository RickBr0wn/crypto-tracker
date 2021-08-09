//
//  UIApplication.swift
//  crypto-tracker
//
//  Created by Rick Brown on 09/08/2021.
//

import Foundation
import SwiftUI

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
