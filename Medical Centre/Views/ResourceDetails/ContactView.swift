//
//  ContactView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct ContactView: View {
    let resource : Resource
    
    var body: some View {
        HStack(spacing: 30){
            if let resourceInfo = resource.resourceInformation{
                ContactPhoneView(resourceInfo: resourceInfo)
                ContactEmailView(resourceInfo: resourceInfo)
            }
            NavigationLink(
                destination: CalendarBookingView(initialMonth: Date(), selectedResourceID: resource.id)){
                VStack{
                    Image(systemName: "book.circle.fill")
                        .font(.system(size: 35))
                    Text("Book")
                        .font(.system(size: 14, weight: .semibold))
                }.foregroundColor(Color("PrimaryBlue"))
            }
        }
    }
}

struct ContactPhoneView : View {
    let resourceInfo: ResourceInformation
    var body: some View{
        VStack{
            if let phone = resourceInfo.phone {
                Link("\(Image(systemName: "phone.circle.fill"))", destination: URL(string: "tel:\(phone)")!)
                    .font(.system(size: 35))
                Text("Call")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("PrimaryBlue"))
            }
        }
    }
}

struct ContactEmailView : View {
    let resourceInfo: ResourceInformation
    var body: some View{
        VStack{
            if let email = resourceInfo.email {
                Link("\(Image(systemName: "envelope.circle.fill"))", destination: URL(string: "mailto:\(email)")!)
                    .font(.system(size: 35))
                Text("Email")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("PrimaryBlue"))
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(resource: Resource(id: "test", name: "John Smyth", imageURL: URL(string: "https://ucarecdn.com/02875021-5cda-4395-b79a-a3f229e5498e/-/crop/338x338/0,15/-/resize/140x140/")!, resourceInformation: ResourceInformation(biography: "Graduated from the Royal College of Surgeons in Ireland. Worked in hospital medicine for many years, general practitioner and a medical physician. Interest in family and general medicine including: dermatology and skin problems, cardiology and chest medicine, general medicine and wellbeing", role: "Doctor", interests: "Physiatrist, Dermatology", address: "16 Redmond Hill, Aungier Street, Dublin 2. D02 YK19", longitude: -8.87897, latitude: 52.71074, phone: 06145265372, email: "test@hotmail.com")))
    }
}
