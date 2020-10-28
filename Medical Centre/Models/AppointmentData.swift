//
//  AppointmentData.swift
//  Medical Centre
//
//  Created by aidan egan on 19/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct AppointmentData: Codable {
    let endTime: String
    let startTime: String
    let resourceName: String
    let resourceId: String
}
