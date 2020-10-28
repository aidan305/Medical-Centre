//
//  Slot.swift
//  TimeKitDemo
//
//  Created by aidan egan on 04/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct Slot : Hashable {
    let startTimeStamp : String
    let endTimeStamp : String
    let formattedStartTime : String
    let formattedEndTime : String
    let resourceName : String
    let resourceID : String
}

