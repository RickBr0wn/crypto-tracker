//
//  HapticManager.swift
//  crypto-tracker
//
//  Created by Rick Brown on 16/08/2021.
//

import Foundation
import SwiftUI

class HapticManager {
  private static let generator = UINotificationFeedbackGenerator()
  
  static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
