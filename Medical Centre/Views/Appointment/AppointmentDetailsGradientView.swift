//
//  AppointmentDetailsGradientView.swift
//  Medical Centre
//
//  Created by aidan egan on 21/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct AppointmentDetailsGradientView: View {
    let dateHelper = DateHelper()
    let appointment: Appointment
    
    var body: some View {
        
        let appointmentDate = dateHelper.convertAppointmentDateToString(appointmentDate: appointment.date)
        let fullDate = appointmentDate.components(separatedBy: " ")
        let day = fullDate[0]
        let date = fullDate[1]
        let fullTime = appointment.time.components(separatedBy: " ")
        let timeDigits = fullTime[0]
        let ampm = fullTime[1]
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1887306869, green: 0.7098545432, blue: 1, alpha: 1)), Color("PrimaryBlue")]), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                .frame(width: UIScreen.screenWidth, height: 200)
                .cornerRadius(10)
            VStack{
                Spacer(minLength: 60)
                HStack(spacing: 90){
                    VStack(alignment: .center){
                        Text(day)
                        Text(date)
                    }.font(.system(size: 18, weight: .semibold))
                    VStack(alignment: .center){
                        Text(timeDigits)
                        Text(ampm)
                    }.font(.system(size: 18, weight: .semibold))
                }.padding()
                Spacer()
                VStack(spacing: 0){
                    Divider()
                        .background(Color.white)
                        .padding(.horizontal)
                    HStack{
                        Text("Appointment Status")
                        Spacer()
                        if appointment.isUpcoming{
                            Text("Upcoming")
                        } else {
                            Text("Completed")
                        }
                    }.padding()
                }
            }.foregroundColor(Color.white)
            .frame(width: UIScreen.screenWidth, height: 200)
        }
    }
}

//struct AppointmentDetailsGradientView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppointmentDetailsGradientView(appointment: Appointment(resourceName: "John McMahon", resourceID: "123435", date: Date(), time: "14:00 am", isUpcoming: true))
//    }
//}
