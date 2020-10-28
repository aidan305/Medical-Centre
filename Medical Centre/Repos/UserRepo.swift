//
//  RepositoryUserUpload.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//


import Foundation
import FirebaseStorage
import Firebase
import SwiftUI

class UserRepo{
    
    let ref = Database.database().reference()
    let dateHelper = DateHelper()
    
    func registerUserIntoDatabase(user: User, _ completion: @escaping () -> Void) {
        
        
        let dateOfBirth = dateHelper.convertDateToString(date: user.DOB ?? Date())
        
        
        let userReference = ref.child("Users").child(user.uid)
        
        let values = ["email": user.email , "name" : user.name, "phone" : user.phoneNumber, "DOB" : dateOfBirth]
        
        userReference.updateChildValues(values, withCompletionBlock: { error, ref in
            if let error = error {
                print(error)
                return
            }
            print("upload complete to \(ref)")
            completion()
            
        })
    }
    
    func readUsersDetails(uid: String, _completion: @escaping (User?) -> Void) {
        
        let firebaseUserEndpoint = URL(string: "https://medical-centre-11fcb.firebaseio.com/Users/\(uid).json?auth=\(ApiKeyStore.firebaseApiKey)")!
        var firebaseUserRequest = URLRequest(url: firebaseUserEndpoint)
        firebaseUserRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: firebaseUserRequest) { data, response, error in
            if error != nil {
                print("this is the \(error)")
                _completion(nil)
            }
            if let data = data {
                do{
                    let userFirebaseData = try JSONDecoder().decode(UserData.self, from: data)
                    
                    let user = User(uid: uid, password: nil, email: userFirebaseData.email, name: userFirebaseData.name, newUser: nil, phoneNumber: userFirebaseData.phone, DOB: nil, profilePictureURL: userFirebaseData.profilePictureURL)
                    
                    _completion(user)
                }
                catch (let error) {
                    print("error decoding \(error)")
                    _completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func uploadUsersProfilePicture(profilePicture: UIImage, id: String, _completion: @escaping (Bool) -> Void){
        let profilePic = Image(uiImage: profilePicture)
        print(profilePic)
        
        let imageIdToStore = id
        let storageRef = Storage.storage().reference().child("Profile_Pictures").child("\(imageIdToStore)")
        
        if let uploadImageData = profilePicture.jpegData(compressionQuality: 0.25){
            storageRef.putData(uploadImageData, metadata: nil, completion: { (result, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                storageRef.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print(err)
                        return
                    }
                    
                    if let url = url {
                        //save the profile picture image url to the users table in firebase
                        print("This is the profile picture url: \(url)")
                        self.addProfilePictureImageUrlToFirebaseUser(url: url, id: id) { (didUpload) in
                            if didUpload{
                               _completion(true)
                            } else{
                                _completion(false)
                            }
                        }
                    }
                })
            })
        }
    }
    
    func addProfilePictureImageUrlToFirebaseUser(url: URL, id: String,  _completion: @escaping (Bool) -> Void){
        
        let firebaseResourceEndpoint = URL(string: "https://medical-centre-11fcb.firebaseio.com/Users/\(id).json")!
        var firebaseRequest = URLRequest(url: firebaseResourceEndpoint)
        firebaseRequest.httpMethod = "PATCH"
        
        // prepare json data
        let jsonBody: [String: Any] = ["profilePictureURL": "\(url)"]
        
        
        let jsonBodyData = try? JSONSerialization.data(withJSONObject: jsonBody)
        firebaseRequest.httpBody = jsonBodyData
        
        let task = URLSession.shared.dataTask(with: firebaseRequest) { data, response, error in
            if error != nil {
                print("this is the \(String(describing: error))")
                _completion(false)
            }
            if let data = data {
                do{
                    _completion(true)
                }
                catch (let error) {
                    print("error decoding \(error)")
                    _completion(false)
                }
            }
        }
        task.resume()
    }
}










