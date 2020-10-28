//
//  PrimaryButtonStyle.swift
//  Medical Centre
//
//  Created by aidan egan on 18/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let height: CGFloat = 60
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .background(configuration.isPressed ? Color.red : Color.yellow)
    }
}
