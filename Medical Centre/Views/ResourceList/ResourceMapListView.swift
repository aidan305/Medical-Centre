//
//  ResourceMapView.swift
//  Medical Centre
//
//  Created by aidan egan on 27/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import MapKit
import URLImage

struct ResourceMapListView: View {
    @State var region : MKCoordinateRegion
    @ObservedObject var resourceStore = ResourceStore()

    init(location: CLLocationCoordinate2D = .init(latitude: 53.275264, longitude: -7.963423)){
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: location.latitude, longitude: location.longitude), span: .init(latitudeDelta: 4.5, longitudeDelta: 3)))
    }
    
    var body: some View{
            VStack{
                Map(coordinateRegion: $region, annotationItems: resourceStore.resources) {resource in
                    MapAnnotation(coordinate: .init(latitude: resource.resourceInformation!.latitude, longitude: resource.resourceInformation!.longitude)) {
                        NavigationLink(
                            destination: ResourceDetailsView(resource: resource),
                            label: {
                                VStack(spacing: 0.5){
                                    URLImage(resource.imageURL,
                                        processors: [ Resize(size: CGSize(width: 50, height: 50), scale: UIScreen.main.scale) ],
                                        content:  {
                                            $0.image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipped()
                                                .clipShape(Circle())
                                                
                                        })
                                            .frame(width: 50, height: 50)
                                Text(resource.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding(.horizontal,6)
                                    .padding(.vertical,4)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1887306869, green: 0.7098545432, blue: 1, alpha: 1)), Color("PrimaryBlue")]), startPoint: .leading, endPoint: .trailing))
                                    .foregroundColor(.white)
                                    .border(Color.black)
                                    .cornerRadius(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4).stroke(Color(.init(white: 0, alpha: 0.5))))
                                }
                            })
                        .foregroundColor(Color("PrimaryBlue"))
                    }
                }
                .foregroundColor(Color(.init(white: 0.9, alpha: 1)))
                .cornerRadius(5)
                .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
            }
            .padding(.horizontal)
    }
}

struct ResourceMapListView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceMapListView()
    }
}
