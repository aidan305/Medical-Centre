//
//  MyInfoView.swift
//  Medical Centre
//
//  Created by aidan egan on 27/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct MyInfoView: View {
    
    @ObservedObject var profile = ProfileStore()
    let dateHelper = DateHelper()
    
    var body: some View {
        
        VStack{
            Divider().hidden()
            HStack{
                Text("My Info")
                    .padding(.leading)
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
            }
            Divider()
            HStack{
                Text("Name")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.gray)
                    .padding(.leading)
                Spacer()
                Text("\(profile.profile?.name ?? "TJohn Symth")")
                    .padding(.trailing)
                    .font(.system(size: 16))
                    .foregroundColor(Color("PrimaryBlue"))
            }.font(.custom("SanFranciscoDisplay-Black", size: 18))
            Divider()
            HStack{
                Text("Email")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.leading)
                Spacer()
                Text("\(profile.profile?.email ?? "TJohn@hotmail.com")")
                    .padding(.trailing)
                    .font(.system(size: 16))
                    .foregroundColor(Color("PrimaryBlue"))
            }.font(.custom("SanFranciscoDisplay-Black", size: 18))
            Divider()
            HStack{
                Text("Phone Number")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.leading)
                Spacer()
                Text("\(profile.profile?.phoneNumber ?? "061 364021")")
                    .padding(.trailing)
                    .font(.system(size: 16))
                    .foregroundColor(Color("PrimaryBlue"))
            }.font(.custom("SanFranciscoDisplay-Black", size: 18))
            Divider()
            HStack{
                Text("DOB")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.leading)
                Spacer()
                Text("\(dateHelper.convertDateToUserReadableString(date: profile.profile?.DOB ?? Date()))")
                    .padding(.trailing)
                    .font(.system(size: 16))
                    .foregroundColor(Color("PrimaryBlue"))
            }.font(.custom("SanFranciscoDisplay-Black", size: 18))
            .padding(.bottom)
        }
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoView()
    }
}
