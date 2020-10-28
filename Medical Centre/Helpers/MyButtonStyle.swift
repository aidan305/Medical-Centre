//
//  MyButtonStyle.swift
//  Medical Centre
//
//  Created by aidan egan on 18/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

struct MyButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding()
      .foregroundColor(.white)
      .background(configuration.isPressed ? Color.red : Color.white)
      .cornerRadius(8.0)
  }

}
