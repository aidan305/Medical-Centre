//
//  SlotRepo.swift
//  TimeKitDemo
//
//  Created by aidan egan on 04/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

struct SlotRepo {
    func getAvailableSlots(resourceID: String,date: Date, projectID: String, _completion: @escaping ([Slot]?) -> Void) {

        let getAvailableSlotsURL = URL(string: "https://api.timekit.io/v2/availability")!
        var request = URLRequest(url: getAvailableSlotsURL)
    
        //Auth
        let username = ""
        let password = ApiKeyStore.timeKitApiKey
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept" )
        request.addValue("application/json", forHTTPHeaderField: "Content-Type" )
        
        //Body of request
        let fromParam = date
        let toParam = add24hoursToDate(date: date)
        let body : [String: Any] = ["project_id": "d27ccfcf-d050-4e64-bc93-fe3add62f8f3", "from": "\(fromParam)", "to": "\(toParam)",
                                    "resources": ["\(resourceID)"]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("this is the \(error)")
                _completion(nil)
            }
            if let data = data {
                do{
                    let slotData = try JSONDecoder().decode(SlotData.self, from: data)
                    _completion(self.createSlot(slotData: slotData))
                }
                catch (let error) {
                    print("error decoding \(error)")
                    _completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func createSlot(slotData: SlotData) -> [Slot] {
        
        var slotsToReturn : [Slot] = []
        
        for slot in slotData.data {
            let startTimestamp = formatTimeStampForIrishTimeZone(timestamp: slot.start)
            let endTimestamp = formatTimeStampForIrishTimeZone(timestamp: slot.end)
            let resourceName = slot.resources[0].name
            let resourceID = slot.resources[0].id
            let formattedStartTime = convertISO8601TimestampToFormattedTimestamp(timestamp: slot.start)
            let formattedEndTime = convertISO8601TimestampToFormattedTimestamp(timestamp: slot.end)
            var newSlot = Slot(startTimeStamp: startTimestamp, endTimeStamp: endTimestamp, formattedStartTime: formattedStartTime, formattedEndTime: formattedEndTime, resourceName: resourceName, resourceID: resourceID)
            slotsToReturn.append(newSlot)
        }
        
        return slotsToReturn
    }
    
    func convertISO8601TimestampToFormattedTimestamp(timestamp: String) -> String {
   
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"//this your string date format
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let convertedDate = dateFormatter.date(from: timestamp)
        
        dateFormatter.dateFormat = "HH:mm"///this is what you want to convert format
       // dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    
    func formatTimeStampForIrishTimeZone(timestamp: String) -> String {
        // NEEDS TO BE LIKE THIS "start": "2020-09-08T22:00:00+01:00",
       
        //What we have
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let convertedDate = dateFormatter.date(from: timestamp)
        
        //What we want (Ireland timezone is UTC+1)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+01:00"
        let timeStamp = dateFormatter.string(from: convertedDate!)
        
        return timeStamp
    }
    
    func add24hoursToDate(date: Date) -> Date{
        var dateToReturn = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 1
        if let datePlus24Hours = Calendar.current.date(byAdding: dateComponent, to: date){
            dateToReturn = datePlus24Hours
        }
        return dateToReturn
    }
}



