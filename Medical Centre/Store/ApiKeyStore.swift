//
//  ApiKeyStore.swift
//  Medical Centre
//
//  Created by aidan egan on 28/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

class ApiKeyStore{
    static var timeKitApiKey: String {
      get {

        guard let filePath = Bundle.main.path(forResource: "TimeKit-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'TMDB-Info.plist'.")
        }
    
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
        }
        return value
      }
    }
    
    static var firebaseApiKey: String {
      get {

        guard let filePath = Bundle.main.path(forResource: "Firebase-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'TMDB-Info.plist'.")
        }
 
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
        }
        return value
      }
    }
}
