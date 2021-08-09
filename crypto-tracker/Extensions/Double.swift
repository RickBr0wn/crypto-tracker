//
//  Double.swift
//  crypto-tracker
//
//  Created by Rick Brown on 06/08/2021.
//

import Foundation
import SwiftUI

extension Double {
  /// Converts a Double into a currency with 2-6 decimal places
  /// ```
  /// Convert 123456 to £1,234.56
  /// Convert 12.3456 to £12.3456
  /// Convert 0.123456 to £0.123456
  /// ```
  private var currencyFormatter6: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = .current
    formatter.currencyCode = "gbp"
    formatter.currencySymbol = "£"
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 6
    
    return formatter
  }
  
  /// Converts a Double into a currency with only 2 decimal places
  /// ```
  /// Convert 123456 to £1,234.56
  /// Convert 12.3456 to £12.34
  /// Convert 0.123456 to £0.12
  /// ```
  private var currencyFormatter2: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = .current
    formatter.currencyCode = "gbp"
    formatter.currencySymbol = "£"
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    
    return formatter
  }
  
  /// Converts a Double into a currency as a String with only 2 decimal places
  /// ```
  /// Convert 123456 to "£1,234.56"
  /// Convert 12.3456 to "£12.34"
  /// Convert 0.123456 to "£0.12"
  /// ```
  func asCurrencyWithTwoDecimals() -> String {
    let number = NSNumber(value: self)
    
    return currencyFormatter2.string(from: number) ?? "£0.00"
  }
  
  /// Converts a Double into a currency as a String with 2-6 decimal places
  /// ```
  /// Convert 123456 to "£1,234.56"
  /// Convert 12.3456 to "£12.3456"
  /// Convert 0.123456 to "£0.123456"
  /// ```
  func asCurrencyWithSixDecimals() -> String {
    let number = NSNumber(value: self)
    
    return currencyFormatter6.string(from: number) ?? "£0.00"
  }
  
  /// Converts a Double into  a String representation
  /// ```
  /// Convert 1.2345 to "1.23"
  /// ```
  func asNumberString() -> String {
    return String(format: "%.2f", self)
  }
  
  /// Converts a Double into  a String representation with percentage symbol
  /// ```
  /// Convert 1.2345 to "1.23%"
  /// ```
  func asPercentString() -> String {
    return asNumberString() + "%"
  }
}
