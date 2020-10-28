//
//  BiographyView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct BiographyView: View {
    let info: ResourceInformation
    var body: some View {
        VStack{
            HStack{
                Text("Biography")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
            }
            Text(info.biography)
                .font(.system(size: 14))
        }
    }
}

struct BiographyView_Previews: PreviewProvider {
    static var previews: some View {
        BiographyView(info: ResourceInformation(biography: "Graduated from the Royal College of Surgeons in Ireland. Worked in hospital medicine for many years, general practitioner and a medical physician. Interest in family and general medicine including: dermatology and skin problems, cardiology and chest medicine, general medicine and wellbeing", role: "Doctor", interests: "Physiatrist, Dermatology", address: "16 Redmond Hill, Aungier Street, Dublin 2. D02 YK19", longitude: -8.87897, latitude: 52.71074, phone: 06145265372, email: "test@hotmail.com"))
    }
}
