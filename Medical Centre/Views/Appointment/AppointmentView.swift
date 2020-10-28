//
//  AnotherView.swift
//  Medical Centre
//
//  Created by aidan egan on 23/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct AppointmentListView: View {
    @ObservedObject var appointmentStore = AppointmentStore()
    let dateHelper = DateHelper()
    let resourceRepo = ResourceRepo()
    
    var body: some View{
        ScrollView{
            //Future appointment
            if appointmentStore.appointments.contains(where: { $0.isUpcoming == true }) { //do the appointment array contain any upcoming appointments
                VStack(alignment: .leading){
                    Text("Upcoming")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                        .padding([.leading, .top])
                    ForEach(appointmentStore.appointments, id: \.self) {appointment in
                        if appointment.isUpcoming{
                            NavigationLink(
                                destination: AppointmentDetailsView(appointment: appointment),
                                label: {
                                    AppointmentCellView(resource: appointment.resourceName, dateOfAppointment: appointment.date, timeStringOfAppointment: appointment.time, isUpcoming: appointment.isUpcoming)
                                })
                        }
                    }
                }
            }
            //Past Appointment
            if appointmentStore.appointments.contains(where: { $0.isUpcoming == false }) {
                VStack(alignment: .leading){
                    Text("Completed")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                        .padding([.leading, .top])
                    ForEach(appointmentStore.appointments, id: \.self) {appointment in
                        if appointment.isUpcoming == false{
                            NavigationLink(
                                destination: AppointmentDetailsView(appointment: appointment),
                                label: {
                                    AppointmentCellView(resource: appointment.resourceName, dateOfAppointment: appointment.date, timeStringOfAppointment: appointment.time, isUpcoming: appointment.isUpcoming)
                                })
                        }
                    }
                }
            }
        }.navigationBarTitle("My Appointments")
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentListView()
    }
}
