//
//  Pharmacy.swift
//  Medical Centre
//
//  Created by aidan egan on 26/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

struct Pharmacy: Identifiable{
    let id = UUID().uuidString
    let name: String
    let latitude, longitude : Double
    let appleMapURLString: String
}

extension Pharmacy{
    static var pharmacies : [Pharmacy] = [.init(name: "Sean Hillery (Pharmacists) Ltd", latitude: 52.711426, longitude: -8.878306, appleMapURLString:  "https://maps.apple.com/?address=32/33%20Shannon%20Road,%20Sixmilebridge,%20Co.%20Clare,%20Ireland&auid=11247753167354074938&ll=52.710721,-8.879459&lsp=9902&q=Se%C3%A1n%20Hillery%20Pharmacists%20Ltd.&_ext=ChkKBQgEEI8BCgQIBRADCgQIBhB4CgQIChAAEiYpOeFvtmVaSkAxcWWoPhTGIcA5t7aVEoxbSkBBLT6cwny+IcBQBA%3D%3D"),
                                   .init(name: "Ballycasey Pharmacy", latitude: 52.713162, longitude: -8.866835, appleMapURLString:  "https://maps.apple.com/?address=58%20Ballycasey%20Park,%20Shannon,%20Co.%20Clare,%20Ireland&auid=13879798589499268652&ll=52.712916,-8.866814&lsp=9902&q=Ballycasey%20Pharmacy&_ext=ChkKBQgEEI8BCgQIBRADCgQIBhB4CgQIChAAEiYp4PMes6laSkAxjWMbTK6/IcA5XslED9BbSkBBcwtmuBa4IcBQBA%3D%3D")]
}
