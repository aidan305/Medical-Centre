//
//  ProfileView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 17/08/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI


struct ProfileView: View {
    
    let userRepo = UserRepo()
    @State private var isShowPhotoLibrary = false
    @State private var profileImage = UIImage(named: "noProfilePicture-1")!
    @State private var saveProfileAlert = false
    @State private var showActivityIndicatorView = false
    @EnvironmentObject var session: SessionStore
    @ObservedObject var profile = ProfileStore()

    
    var body: some View {
        ZStack{
            if showActivityIndicatorView == true {
                VStack{
                    ActivityIndicatorView()
                    Text("Saving picture....")
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .semibold))
                }.padding()
                .background(Color.black)
                .cornerRadius(8)
            } else {
                ScrollView{
                    VStack(spacing: 20){
                        ProfileGradientView(profileImage: self.$profileImage, isShowPhotoLibary: $isShowPhotoLibrary)
                        Spacer(minLength: 35)
                        MyInfoView()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding()
                            .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
                        Spacer()
                        Button("Sign Out"){
                            self.session.signOut()
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Profile")
        .onAppear(perform: {
            checkForProfilePic()
        })
        .background(Color(.init(white: 0.95, alpha: 1)))
        .sheet(isPresented: $isShowPhotoLibrary, onDismiss: {saveProfileAlert = true}) {
            ImagePicker(selectedImage: self.$profileImage, sourceType: .photoLibrary)
        }
        .alert(isPresented: $saveProfileAlert) {
            Alert(title: Text("Profile Picture"), message: Text("Are you sure you want to save this profile picture?"), primaryButton: .default(Text("Save")) {
                showActivityIndicatorView = true
                print("upload image to Firebase")
                if let userID = profile.profile?.uid{
                    userRepo.uploadUsersProfilePicture(profilePicture: profileImage, id: userID) { didSave in
                        print(didSave)
                        showActivityIndicatorView = false
                    }
                }
            }, secondaryButton: .cancel())
        }
    }
    
    func checkForProfilePic(){
        if let savedProfilePictureURL = profile.profile?.profilePictureURL{
            let url = URL(string: savedProfilePictureURL)!
            if let data = try? Data(contentsOf: url)
            {
                let image: UIImage = UIImage(data: data)!
                self.profileImage = image
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
    

}

