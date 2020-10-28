//
//  Appointment.swift
//  Medical Centre
//
//  Created by aidan egan on 21/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

struct Appointment: Hashable {
    let resourceName: String
    let resourceID: String
    let date: Date
    let time: String
    let isUpcoming: Bool
    let resourceInfo: ResourceInformation
}
