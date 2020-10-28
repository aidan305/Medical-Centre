//
//  PharmacyMapView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import MapKit

struct PharmacyMapView: View {
    @State var region : MKCoordinateRegion

    init(location: CLLocationCoordinate2D = .init(latitude: 52.7114, longitude: -8.8744)){
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: location.latitude, longitude: location.longitude), span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    }
    
    var body: some View{
            VStack{
                HStack{
                    Text("Pharmacies near me")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                    Spacer()
                    Text("See all >")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                }
                Map(coordinateRegion: $region, annotationItems: Pharmacy.pharmacies) {pharmacy in
                    MapAnnotation(
                        coordinate: CLLocationCoordinate2D(latitude: pharmacy.latitude, longitude: pharmacy.longitude),
                        anchorPoint: CGPoint(x: 0.5, y: 0.5)
                    ) {
                        ZStack{
                        Circle()
                            .fill(Color.white)
                        Image(systemName: "cross.case.fill")
                        }
                            .foregroundColor(Color("PrimaryBlue"))
                            .frame(width: 50, height: 50)
                            .onTapGesture(perform: {
                                UIApplication.shared.open(
                                    URL.init(
                                        string: pharmacy.appleMapURLString
                                    )!,
                                    options: [:],
                                    completionHandler: nil
                                )
                              })
                    }
                }
                .foregroundColor(Color(.init(white: 0.9, alpha: 1)))
                .cornerRadius(5)
                .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
            }
            .padding(.horizontal)
            .frame(height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct PharmacyMapView_Previews: PreviewProvider {
    static var previews: some View {
        PharmacyMapView()
    }
}

