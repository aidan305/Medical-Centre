//
//  CustomNavigationBarViewModifier.swift
//  Medical Centre
//
//  Created by aidan egan on 24/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct CustomNavigationBarViewModifier: ViewModifier {
    var sectionTitle: String
    var spacing: CGFloat
    @Binding var tabSelection: Int
    
    func body(content: Content) -> some View {
        return content
            .navigationBarItems(leading:
                HStack(spacing: spacing){
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.system(size: 35))
                    }.foregroundColor(Color("PrimaryBlue"))
                    Text(sectionTitle)
                        .font(.custom("SanFranciscoRounded-Bold", size: 35))
                        .foregroundColor(Color("PrimaryBlue"))
                        
                },
                trailing:
                HStack {
                    Button(action: switchTab) {
                        ZStack{
                            Image(systemName: "cart.fill")
                                .font(.system(size: 35))

                        }
                    }.foregroundColor(Color("PrimaryBlue"))
            }
        )
    }
    
    func switchTab(){
        tabSelection = 2
    }
}

struct CustomViewModifierHideTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
            }
    }
}

