//
//  ResourceDetailsView.swift
//  Medical Centre
//
//  Created by aidan egan on 13/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage
import MapKit

struct ResourceDetailsView: View {
    let resource: Resource
    let resourcesCoordinates: CLLocationCoordinate2D
    
    init(resource: Resource){
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.purple]
        self.resource = resource
        self.resourcesCoordinates = CLLocationCoordinate2D.init(latitude: resource.resourceInformation?.latitude ?? 0.0, longitude: resource.resourceInformation?.longitude ?? 0.0)
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 15){
                    ResourceImageGradientView(resource: resource)
                if let resourceInformation = resource.resourceInformation{
                    AddressView(resourceInfo: resourceInformation)
                    ContactView(resource: resource)
                    BiographyView(info: resourceInformation)
                        .padding(.horizontal)
                    SpecialityView(resourceInfo: resourceInformation)
                    ResourceLocationMapView(coordinates: resourcesCoordinates)
                }
            }.padding(.horizontal)
            .navigationBarTitle(resource.resourceInformation?.role ?? "Doctor", displayMode: .inline)
        }
    }
}



struct ResourceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceDetailsView(resource:
                                Resource(id: "test", name: "John Smyth", imageURL: URL(string: "https://ucarecdn.com/02875021-5cda-4395-b79a-a3f229e5498e/-/crop/338x338/0,15/-/resize/140x140/")!, resourceInformation: ResourceInformation(biography: "Graduated from the Royal College of Surgeons in Ireland. Worked in hospital medicine for many years, general practitioner and a medical physician. Interest in family and general medicine including: dermatology and skin problems, cardiology and chest medicine, general medicine and wellbeing", role: "Doctor", interests: "Physiatrist, Dermatology", address: "16 Redmond Hill, Aungier Street, Dublin 2. D02 YK19", longitude: -8.87897, latitude: 52.71074, phone: 06145265372, email: "test@hotmail.com")))
    }
}


