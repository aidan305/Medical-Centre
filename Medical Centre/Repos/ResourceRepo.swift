//
//  ResourceRepo.swift
//  Medical Centre
//
//  Created by aidan egan on 12/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

class ResourceRepo{
    
    let defaultImageURL = URL(string: "https://cdn4.vectorstock.com/i/thumb-large/87/88/smart-doctor-character-design-doctor-icon-and-vector-7808788.jpg")
    
    func getAllResources(_completion: @escaping ([Resource]?) -> Void) {
        
        let getAvailableServicesURL = URL(string: "https://api.timekit.io/v2/resources")!
        var request = URLRequest(url: getAvailableServicesURL)
        
        //Auth
        let username = ""
        let password = ApiKeyStore.timeKitApiKey
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept" )
        request.addValue("application/json", forHTTPHeaderField: "Content-Type" )
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("this is the \(error)")
                _completion(nil)
            }
            if let data = data {
                do{
                    let resourceData = try JSONDecoder().decode(ResourceData.self, from: data)
                    let resources = self.createResource(resourceData: resourceData) { resources in
                    _completion(resources)
                    }
                }
                catch (let error) {
                    print("error decoding \(error)")
                    _completion(nil)
                }
            }
        }
        task.resume()
    }
    
    
    func createResource(resourceData: ResourceData, _completion: @escaping ([Resource]?) -> Void) {
        
        //to pair up with the Firebase info you would have to do another call getting the extra info on the resource from Firebase and then create the resource
        
        //https://medical-centre-11fcb.firebaseio.com/Resources/1b15bff2-f176-47d9-99c1-b3d95e31192a.json
        
        //1. Firebase call with specific id to retrieve firebase information
        
        
        var resourcesToReturn : [Resource] = []
        
        for resource in resourceData.data {
            let id = resource.id
            readResourceDetailsFromFirebase(id: id) { firebaseInfo in
                let name = resource.name
                let imageURL = URL(string: resource.image) ?? self.defaultImageURL
                
                //2. Create the resource with ResourceInfoTimeKitData (resourceData.data) and ResourceFirebaseData
                let resource = Resource(id: resource.id, name: name, imageURL: imageURL!, resourceInformation: firebaseInfo)
                resourcesToReturn.append(resource)
                if resourceData.data.count == resourcesToReturn.count {
                    _completion(resourcesToReturn)
                }
            }
        }
    }
    
    func readResourceDetailsFromFirebase(id: String, _completion: @escaping (ResourceInformation?) -> Void) {
        
        var firebaseResourceEndpoint = URL(string: "https://medical-centre-11fcb.firebaseio.com/Resources/\(id).json?auth=\(ApiKeyStore.firebaseApiKey)")!
        var firebaseRequest = URLRequest(url: firebaseResourceEndpoint)
        firebaseRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: firebaseRequest) { data, response, error in
            if error != nil {
                print("this is the \(error)")
                _completion(nil)
            }
            if let data = data {
                do{
                    let resourceFirebaseData = try JSONDecoder().decode(ResourceFirebaseData.self, from: data)
                    let firebaseResourceInformation = ResourceInformation(biography: resourceFirebaseData.biography, role: resourceFirebaseData.role, interests: resourceFirebaseData.interests, address: resourceFirebaseData.address, longitude: resourceFirebaseData.longitude, latitude: resourceFirebaseData.latitude, phone: Int(resourceFirebaseData.phone) ?? 00, email: resourceFirebaseData.email)
                   _completion(firebaseResourceInformation)
                }
                catch (let error) {
                    print("error decoding \(error)")
                    _completion(nil)
                }
            }
        }
        task.resume()
    }
}
