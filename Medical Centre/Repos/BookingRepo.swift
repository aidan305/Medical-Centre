//
//  BookingRepo.swift
//  Medical Centre
//
//  Created by aidan egan on 16/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

class BookingRepo{
    
    let appointmentRepo = AppointmentRepo()
    
    func processBooking(slot: Slot, _completion: @escaping (Bool) -> Void){
        
        let jsonBodyDic: [String: Any] = ["resource_id": slot.resourceID, "graph": "confirm_decline", "start": slot.startTimeStamp,"end": slot.endTimeStamp,"what": "gp appointment","where": "Shannon medical centre, Clare, V14 D377, Ireland","description": "The lightning strikes at 10:04 PM exactly! I need you to be there Doc!","customer": ["name":"tim smith", "email":"egana704@gmail.com","phone": "(916) 555-4385","voip": "McFly","timezone": "Europe/Dublin"]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBodyDic)
        
        let url = URL(string: "https://api.timekit.io/v2/bookings")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        //Auth
        let username = ""
        let password = ApiKeyStore.timeKitApiKey
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept" )
        request.addValue("application/json", forHTTPHeaderField: "Content-Type" )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                _completion(false)
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                //this contains id = "a0448c2f-cfa0-4f98-b10f-7c66567789e4"  which is the booking id or appoitnment id which we should use to save to firebase. pass id to saveAppointmentToFirebase func
                if let responseJsonData = responseJSON["data"] as? [String: Any]{
                    if let appointmentID = responseJsonData["id"] as? String {
                        self.appointmentRepo.saveAppointmentToFirebase(slot: slot, userID: globalUserID, appointmentID: appointmentID) { (didSave) in
                            _completion(true)
                        }
                    }
                }  
            }
        }
        task.resume()
    }
}
