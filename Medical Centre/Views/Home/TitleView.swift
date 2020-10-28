//
//  TitleView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    @ObservedObject var profile = ProfileStore()
    
    var body: some View {
        HStack{
            VStack{
                Text("Welcome \(profile.profile?.name ?? "👋")")
                    .font(.system(size: 28))
                    .bold()
                    .frame(alignment: .leading)
                Text("Your health in your pocket!")
                    .font(.system(size: 16))
            }.padding(.leading)
            Spacer()
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
        HomeView()
    }
}
