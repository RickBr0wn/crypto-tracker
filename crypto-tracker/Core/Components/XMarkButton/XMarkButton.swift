//
//  XMarkButton.swift
//  crypto-tracker
//
//  Created by Rick Brown on 16/08/2021.
//

import SwiftUI

struct XMarkButton: View {
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    Button(action: {
      presentationMode.wrappedValue.dismiss()
    }, label: {
      Image(systemName: "xmark")
        .font(.headline)
    })
  }
}

struct XMarkButton_Previews: PreviewProvider {
  static var previews: some View {
    XMarkButton()
  }
}
