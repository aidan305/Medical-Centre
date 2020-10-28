//
//  AppointmentRepo.swift
//  Medical Centre
//
//  Created by aidan egan on 18/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

class AppointmentRepo {
    func saveAppointmentToFirebase(slot: Slot, userID: String?, appointmentID: String, _completion: @escaping (Bool) -> Void){
        var firebaseResourceEndpoint = URL(string: "https://medical-centre-11fcb.firebaseio.com/Appointments/\(appointmentID).json?auth=\(ApiKeyStore.firebaseApiKey)")!
        var firebaseRequest = URLRequest(url: firebaseResourceEndpoint)
        firebaseRequest.httpMethod = "PUT"
        
        // prepare json data
        let jsonBody: [String: Any] = ["startTime": "\(slot.startTimeStamp)",
                                       "endTime": "\(slot.endTimeStamp)",
                                       "resourceName": "\(slot.resourceName)",
                                       "resourceId" : "\(slot.resourceID)",
                                       "userID" : "\(userID ?? "no user ID available")"]
        
        let jsonBodyData = try? JSONSerialization.data(withJSONObject: jsonBody)
        firebaseRequest.httpBody = jsonBodyData
        
        let task = URLSession.shared.dataTask(with: firebaseRequest) { data, response, error in
            if error != nil {
                print("this is the \(String(describing: error))")
                _completion(false)
            }
            if let data = data {
                do{
                    print(data)
                    self.updateUserWithAppointment(userID: userID, newAppointmentID: appointmentID) { updatedSuccessfull in
                        if updatedSuccessfull ==  true {
                            _completion(true)
                        }
                        else {
                            _completion(false)
                        }
                    }
                }
                catch (let error) {
                    print("error decoding \(error)")
                    _completion(false)
                }
            }
        }
        task.resume()
    }
    
    func updateUserWithAppointment(userID: String?, newAppointmentID: String, _completion: @escaping (Bool) -> Void){
        
        var allOfUsersAppointments : [String] = []
        //Step 1: Read the appointments that already there into an array
        if let userID = userID {
        self.getUsersAppointmentIDs(userId: userID) { (arrOfOriginalAppointments) in
            if var appointments = arrOfOriginalAppointments {
                //Step 2: Append the new appointment to that array
                appointments.append(newAppointmentID)
                allOfUsersAppointments = appointments
            } else {
                allOfUsersAppointments.append(newAppointmentID)
            }
            
            //Step 3: perform the http request of type PATCH:
            
            let firebaseAppointmentEndpoint = URL(string: "https://medical-centre-11fcb.firebaseio.com/Users/\(userID).json?auth=\(ApiKeyStore.firebaseApiKey)")!
            var firebaseUpdateAppointmentRequest = URLRequest(url: firebaseAppointmentEndpoint)
            firebaseUpdateAppointmentRequest.httpMethod = "PATCH"
            
            // prepare request body data
            let jsonBody: [String: Any] = ["Appointment": allOfUsersAppointments]
            
            let jsonBodyData = try? JSONSerialization.data(withJSONObject: jsonBody)
            firebaseUpdateAppointmentRequest.httpBody = jsonBodyData
            
            
            let task = URLSession.shared.dataTask(with: firebaseUpdateAppointmentRequest) { data, response, error in
                if error != nil {
                    print("this is the \(String(describing: error))")
                    _completion(false)
                }
                if let data = data {
                    do{
                        print(data)
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
        } else {
            // we have no user id. i.e user isnt logged in and doesnt have an account
        }
    }
    
    func getUsersAppointmentIDs(userId: String, _completion: @escaping ([String]?) -> Void) {
        
        let getAppointmentsEndpoint = URL(string: "https://medical-centre-11fcb.firebaseio.com/Users/\(userId)/Appointment.json?auth=\(ApiKeyStore.firebaseApiKey)")!
        var firebaseGetAppointmentRequest = URLRequest(url: getAppointmentsEndpoint)
        firebaseGetAppointmentRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: firebaseGetAppointmentRequest) { data, response, error in
            if error != nil {
                print("this is the \(String(describing: error))")
                _completion(nil)
            }
            if let data = data {
                do{
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if responseJSON == nil{
                        _completion(nil)
                    }
                    if let arrayOFAppointments = responseJSON as? [String]{
                            _completion(arrayOFAppointments)
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
    
    func getAllUsersAppointments(userId: String, _completion: @escaping ([Appointment]?) -> Void) {
        
        var appointmentsToReturn = [Appointment]()
        let resourceRepo = ResourceRepo()
    
        getUsersAppointmentIDs(userId: userId) { (appointmentIDs) in
            for appointment in appointmentIDs ?? [] {
                var getAppointmentDetailsEndpoint = URL(string: "https://medical-centre-11fcb.firebaseio.com/Appointments/\(appointment).json?auth=\(ApiKeyStore.firebaseApiKey)")!
                var firebaseGetAppointmentDetailsRequest = URLRequest(url: getAppointmentDetailsEndpoint)
                firebaseGetAppointmentDetailsRequest.httpMethod = "GET"
                
                let task = URLSession.shared.dataTask(with: firebaseGetAppointmentDetailsRequest) { data, response, error in
                    if error != nil {
                        print("this is the \(error)")
                        _completion(nil)
                    }
                    if let data = data {
                        do{
                            let appoiontmentFirebaseData = try JSONDecoder().decode(AppointmentData.self, from: data)
                            
                            resourceRepo.readResourceDetailsFromFirebase(id: appoiontmentFirebaseData.resourceId) { (resourceInfo) in
                                let appointment = self.createAppointmentFromData(appointmentData: appoiontmentFirebaseData, resourceInfo: resourceInfo ?? ResourceInformation(biography: "", role: "", interests: "", address: "", longitude: 0, latitude: 0, phone: 1234, email: "test@test.com"))
                                appointmentsToReturn.append(appointment)
                            
                                if appointmentsToReturn.count == appointmentIDs?.count{
                                    _completion(appointmentsToReturn)
                                }
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
        }
    }
    
    func createAppointmentFromData(appointmentData: AppointmentData, resourceInfo: ResourceInformation) -> Appointment {
        let appointmentToReturn : Appointment
        let dateHelper = DateHelper()
        
        appointmentToReturn = Appointment(resourceName: appointmentData.resourceName, resourceID: appointmentData.resourceId, date: dateHelper.convertFirebaseStoredStringToDate(date: appointmentData.startTime), time: dateHelper.convertDateStringToUserReadableTimeString(timestamp: appointmentData.startTime), isUpcoming: dateHelper.isDateStringInTheFuture(appointmentDateString: appointmentData.startTime), resourceInfo: resourceInfo)
        
        return appointmentToReturn
    }
}


