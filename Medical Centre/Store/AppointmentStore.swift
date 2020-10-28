//
//  AppointmentStore.swift
//  Medical Centre
//
//  Created by aidan egan on 19/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

class AppointmentStore: ObservableObject{
    @Published var appointments : [Appointment] = []
    @Published var upcomingAppointment: Appointment?
    let appointmentRepo = AppointmentRepo()
    
    init(){
        if let userID = globalUserID{
            appointmentRepo.getAllUsersAppointments(userId: userID) { (appointments) in
                if var allAppointments = appointments{
                    allAppointments = allAppointments.sorted(by: {$0.date < $1.date})
                    DispatchQueue.main.async { [self] in
                        upcomingAppointment = allAppointments.first(where: { $0.isUpcoming == true })! // SORT THIS FORCE ! 
                        self.appointments = allAppointments
                    }
                }
            }
        }
    }
}
