//
//  ResourceLocationMapView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import MapKit

struct ResourceLocationMapView: View {
    @State var region : MKCoordinateRegion
    let coordinates : CLLocationCoordinate2D
    
    init(coordinates: CLLocationCoordinate2D) {
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: coordinates.latitude, longitude:coordinates.longitude), span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        self.coordinates = coordinates
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Location")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
            Map(coordinateRegion: $region, annotationItems: [MyAnnotationItem(coordinate: coordinates)]) { resourceLocation in
                MapMarker(coordinate: resourceLocation.coordinate, tint: Color("PrimaryBlue"))
            }
            .cornerRadius(5)
            .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
            .frame(height: 300)
            
        }.padding(.horizontal)
    }
}

struct ResourceLocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceLocationMapView(coordinates: CLLocationCoordinate2D(latitude: 52.710740, longitude: -8.878970))
        ResourceDetailsView(resource:
                                Resource(id: "test", name: "John Smyth", imageURL: URL(string: "https://ucarecdn.com/02875021-5cda-4395-b79a-a3f229e5498e/-/crop/338x338/0,15/-/resize/140x140/")!, resourceInformation: ResourceInformation(biography: "Graduated from the Royal College of Surgeons in Ireland. Worked in hospital medicine for many years, general practitioner and a medical physician. Interest in family and general medicine including: dermatology and skin problems, cardiology and chest medicine, general medicine and wellbeing", role: "Doctor", interests: "Physiatrist, Dermatology", address: "16 Redmond Hill, Aungier Street, Dublin 2. D02 YK19", longitude: -8.87897, latitude: 52.71074, phone: 06145265372, email: "test@hotmail.com")))
    }
}
