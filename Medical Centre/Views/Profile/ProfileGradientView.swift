//
//  ProfileGradientView.swift
//  Medical Centre
//
//  Created by aidan egan on 27/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct ProfileGradientView: View {
    
    @Binding var profileImage: UIImage
    @Binding var isShowPhotoLibary: Bool
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1887306869, green: 0.7098545432, blue: 1, alpha: 1)), Color("PrimaryBlue")]), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                .frame(width: UIScreen.screenWidth, height: 200)
                .cornerRadius(10)
            
            Image(uiImage: self.profileImage)
                .resizable()
                .frame(width: 140, height: 135)
                .clipShape(Circle())
                .offset(y: 68)
                .shadow(radius: 3)
            Button(action: {
                self.isShowPhotoLibary = true
            }) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 28))
                    .background(Circle().foregroundColor(.white).frame(width: 46, height: 46))
            }.offset(x: 45, y: 10)
        }
    }
}

//struct ProfileGradientView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileGradientView(profileImage: <#Binding<UIImage>#>, isShowPhotoLibary: <#Binding<Bool>#>)
//    }
//}
