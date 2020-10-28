//
//  Home.swift
//  Medical Centre
//
//  Created by aidan egan on 22/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage
import MapKit


struct HomeView: View {
    @ObservedObject var resourceStore = ResourceStore()
    @ObservedObject var appointmentStore = AppointmentStore()
    
    var body: some View {
        ScrollView(){
            VStack(spacing: 10){
                TitleView()
                if let upcomingappointment = appointmentStore.upcomingAppointment{
                NavigationLink(
                    destination: AppointmentDetailsView(appointment: upcomingappointment),
                    label: {
                        AppointmentCellView(resource: upcomingappointment.resourceName, dateOfAppointment: upcomingappointment.date, timeStringOfAppointment: upcomingappointment.time, isUpcoming: true)

                    })
                }
                HealthButtonsView()
                ResourceHorizontalScrollView()
                PharmacyMapView()
            }.padding(.top)
            .background(Color(.init(white: 0.95, alpha: 1)))
        }
        .navigationBarTitle("Home")
    }
}


struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(resourceStore: ResourceStore.init())
    }
}
