//
//  String.swift
//  crypto-tracker
//
//  Created by Rick Brown on 17/08/2021.
//

import Foundation

extension String {
  var removingHTMLOccurances: String {
    return self.replacingOccurrences(of: "<[^>]+>", with:  "", options: .regularExpression, range: nil)
  }
}

