//
//  UserData.swift
//  Medical Centre
//
//  Created by aidan egan on 19/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct UserData: Codable {
    let email : String
    let name: String
    let phone: String
    let DOB: String
    let profilePictureURL: String?
}
