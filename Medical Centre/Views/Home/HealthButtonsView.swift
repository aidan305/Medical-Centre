//
//  HealthButtonsView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct HealthButtonsView: View {
    var body: some View {
        HStack{
            NavigationLink(
                destination: WebView(url: "https://www2.hse.ie/coronavirus/").modifier(CustomViewModifierHideTabBar())){
                ZStack{
                    Image("fadedVirusBackground")
                        .resizable()
                        .frame(width: 160, height: 50)
                        .scaledToFill()
                        .cornerRadius(5)
                        .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
                    
                    Text("Covid-19")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                }.padding(.horizontal)
            }
            NavigationLink(
                destination: WebView(url: "https://www.irishtimes.com/news/health").modifier(CustomViewModifierHideTabBar())){
                ZStack{
                    Image("HealthBackgroundFaded")
                        .resizable()
                        .frame(width: 160, height: 50)
                        .scaledToFill()
                        .cornerRadius(5)
                        .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
                    
                    Text("Health News")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                }.padding(.horizontal)
            }
        }
    }
}

struct HealthButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        HealthButtonsView()
        HomeView()
    }
}
