//
//  ResourceData.swift
//  Medical Centre
//
//  Created by aidan egan on 12/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct ResourceData: Codable {
    let data: [ResourceInfoTimeKitData]
}

struct ResourceInfoTimeKitData: Codable {
    let id: String
    let name: String
    let image: String
}

struct ResourceFirebaseData: Codable {
    let biography: String
    let interests: String
    let role: String
    let address: String
    let longitude: Double
    let latitude: Double
    let phone: String
    let email: String
}
