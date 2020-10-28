//
//  NavigationLazyView.swift
//  Medical Centre
//
//  Created by aidan egan on 25/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

//https://stackoverflow.com/questions/57594159/swiftui-navigationlink-loads-destination-view-immediately-without-clicking
//This is the solution found online to load the resource details on demand (i.e when clicked on the home screen by the user)
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

