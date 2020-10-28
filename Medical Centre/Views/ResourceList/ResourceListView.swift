//
//  ResourceListView.swift
//  Medical Centre
//
//  Created by aidan egan on 27/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage

struct ResourceListView: View {
    
    @ObservedObject var resourceStore = ResourceStore()
    
    var body: some View {
        List(){
            ForEach(resourceStore.resources, id: \.self) { resource in
                ZStack(alignment: .leading){
                    HStack() {
                        URLImage(resource.imageURL)
                            .frame(height: 100)
                            .clipShape(Circle())
                            
                        VStack(alignment: .leading, spacing: 8){
                            Text(resource.name)
                                .font(.system(size: 16, weight: .semibold))
                            Text(resource.resourceInformation?.role ?? "")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                            HStack{
                                ForEach(0..<5, id: \.self){ num in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.orange)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                NavigationLink(
                    destination: ResourceDetailsView(resource: resource),
                    label: {
                      EmptyView()
                    })
                }.buttonStyle(PlainButtonStyle())
                
            }.frame(height: 100)
        }
    }
}

struct ResourceListView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceListView()
    }
}
