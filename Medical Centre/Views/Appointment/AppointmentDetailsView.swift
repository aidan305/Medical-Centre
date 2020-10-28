//
//  AppointmentDetailsView.swift
//  Medical Centre
//
//  Created by aidan egan on 18/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

struct AppointmentDetailsView: View{
    let appointment: Appointment
    let dateHelper = DateHelper()
    let resourceRepo = ResourceRepo()
    
    var body: some View {
        ScrollView{
            VStack(){
                AppointmentDetailsGradientView(appointment: appointment)
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                    Text("Your \(appointment.resourceInfo.role)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                        HStack(spacing: 10){
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color("PrimaryBlue"))
                        Text(appointment.resourceName)
                    }.font(.system(size: 18))
                }
                    Spacer()
                }.padding(.horizontal)
                AddressView(resourceInfo: appointment.resourceInfo)
                HStack{
                    ContactPhoneView(resourceInfo: appointment.resourceInfo)
                    ContactEmailView(resourceInfo: appointment.resourceInfo)
                }
                    ResourceLocationMapView(coordinates: .init(latitude: appointment.resourceInfo.latitude, longitude: appointment.resourceInfo.longitude))
            }
        }
    }
}

struct AppointmentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentDetailsView(appointment: Appointment(resourceName: "Aidan Egan", resourceID: "12345", date: Date(), time: "14:33", isUpcoming: false, resourceInfo: ResourceInformation(biography: "test", role: "Doctor", interests: "", address: "16 Redmomd, hill, clare ", longitude: -8.6242, latitude: 52.6680, phone: 123, email: "test@test.com")))
    }
}
