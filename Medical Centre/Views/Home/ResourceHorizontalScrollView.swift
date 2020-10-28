//
//  ResourceHorizontalScrollView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage




struct ResourceHorizontalScrollView: View {
   @ObservedObject var resourceStore = ResourceStore()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Doctors near me")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("PrimaryBlue"))
                Spacer()
                NavigationLink(
                    destination: ResourceVerticalView()){
                    Text("See all >")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                } 
            }.padding(.horizontal)
            ScrollView(.horizontal){
                HStack(spacing : 0){
                    ForEach(resourceStore.resources, id: \.self){ resource in
                        NavigationLink(
                            destination: NavigationLazyView(ResourceDetailsView(resource: resource))){
                            VStack(spacing: 11){
                                URLImage(resource.imageURL) { proxy in
                                    proxy.image
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                }.clipShape(Circle())
                                VStack(spacing: 5){
                                    VStack(spacing: 0){
                                        let nameSplit = resource.name.components(separatedBy: " ")
                                        Text(nameSplit[0])
                                            .font(.system(size: 12, weight: .bold))
                                        Text(nameSplit[1])
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                    Text(resource.resourceInformation?.role ?? "")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.gray)
                                    Divider()
                                    Text("1.3 km")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(Color("PrimaryBlue"))
                                }
                            }.padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
                            .padding(.horizontal)
                        }
                    }.padding(.bottom)
                    .padding(.top, 2)
                }
            }
        }
    }
}

struct ResourceHorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceHorizontalScrollView()
        HomeView()
    }
}
