//
//  ResourceImageGradientView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import URLImage

struct ResourceImageGradientView: View {
    let resource: Resource
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1887306869, green: 0.7098545432, blue: 1, alpha: 1)), Color("PrimaryBlue")]), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                .frame(width: UIScreen.screenWidth, height: 200)
                .cornerRadius(10)
            HStack{
                URLImage(resource.imageURL) { proxy in
                    proxy.image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                    
                }.clipShape(Circle())
                .offset(x: -60, y: 90)
                VStack(alignment: .leading, spacing: 15){
                    Text(resource.name)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .semibold))
                    Text(resource.resourceInformation?.role ?? "")
                        .foregroundColor(Color.white)
                        .font(.system(size: 14, weight: .semibold))
                }.offset(x: -60, y: 70)
            }
        }.padding(.bottom, 50)
    }
}

struct ResourceImageGradientView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceImageGradientView(resource: Resource(id: "test", name: "John Smyth", imageURL: URL(string: "https://ucarecdn.com/02875021-5cda-4395-b79a-a3f229e5498e/-/crop/338x338/0,15/-/resize/140x140/")!, resourceInformation: ResourceInformation(biography: "Graduated from the Royal College of Surgeons in Ireland. Worked in hospital medicine for many years, general practitioner and a medical physician. Interest in family and general medicine including: dermatology and skin problems, cardiology and chest medicine, general medicine and wellbeing", role: "Doctor", interests: "Physiatrist, Dermatology", address: "16 Redmond Hill, Aungier Street, Dublin 2. D02 YK19", longitude: -8.87897, latitude: 52.71074, phone: 06145265372, email: "test@hotmail.com")))
    }
}
