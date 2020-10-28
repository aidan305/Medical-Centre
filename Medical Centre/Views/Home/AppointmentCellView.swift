//
//  UpcomingAppointmentView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct AppointmentCellView: View {
    
    let resource: String
    let dateOfAppointment: Date
    let timeStringOfAppointment: String
    let isUpcoming : Bool
    let dateHelper = DateHelper()
    
    var body: some View {
        ZStack(alignment: .leading){
            Image("appointmentBackground")
                .resizable()
                .frame(height: 120)
                .foregroundColor(Color.white)
                .cornerRadius(5)
                .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
            VStack(alignment: .leading, spacing: 14){
                if isUpcoming{
                Text("Upcoming appointment")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.gray)
                } else {
                    Text("Past appointment")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.gray)
                }
                Text(resource)
                    .font(.system(size: 14, weight: .semibold))
                HStack(spacing:4){
                    Text(dateHelper.convertAppointmentDateToString(appointmentDate: dateOfAppointment))
                    Text("|")
                    Text(timeStringOfAppointment)
                }.font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color("PrimaryBlue"))
            }.padding(.leading, 35)
        }.padding(.horizontal)
    }
}

struct AppointmentCellView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentCellView(resource: "test doctor", dateOfAppointment : Date(), timeStringOfAppointment : "test time", isUpcoming: false)
        HomeView()
    }
}
