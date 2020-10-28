//
//  SlotData.swift
//  TimeKitDemo
//
//  Created by aidan egan on 04/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct SlotData: Codable {
    let data : [SlotDetails]
}

struct SlotDetails: Codable {
    let start : String
    let end : String
    let resources : [ResourceDetails]
}

struct ResourceDetails: Codable {
    let id : String
    let name: String
}

