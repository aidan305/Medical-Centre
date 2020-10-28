//
//  Resource.swift
//  Medical Centre
//
//  Created by aidan egan on 12/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

struct Resource: Hashable, Identifiable {
    let id: String
    let name: String
    let imageURL: URL
    let resourceInformation: ResourceInformation?
}

struct ResourceInformation:  Hashable {
    let biography: String
    let role: String
    let interests: String
    let address: String
    let longitude: Double
    let latitude: Double
    let phone: Int
    let email: String
}

