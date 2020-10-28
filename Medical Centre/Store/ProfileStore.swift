//
//  ProfileStore.swift
//  Pet StoreApp
//
//  Created by aidan egan on 18/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class ProfileStore: ObservableObject {
    @Published var profile : User?
    let userRepo = UserRepo()
    @State var refreshHeartinView: Bool = false
    
    init(){

            if let userID = globalUserID{
                userRepo.readUsersDetails(uid: userID) { (user) in
                    DispatchQueue.main.async {
                    self.profile = user
                    }
                }
            }
        
    }
}

