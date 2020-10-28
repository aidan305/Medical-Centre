//
//  ContentView.swift
//  Pet StoreApp
//
//  Created by aidan egan on 22/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import Introspect

class TabSwitch: ObservableObject{
    @Published var tabName = "Home"
}

struct ContentView1: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var tabswitch = TabSwitch()
    
    var body: some View {
        //TabView(selection: .constant(tabswitch.tabName))
        TabView(){
            NavigationView{
                HomeView().navigationBarTitle("", displayMode: .inline)
                    .navigationBarTitle("Home")
                    .introspectTabBarController { (UITabBarController) in
                        UITabBarController.tabBar.isHidden = false
                    }
                
            }
            .tabItem {
                Text("Home")
                Image(systemName: "house.fill")
            }.tag("Home")
            
            NavigationView{
                AppointmentView().navigationBarTitle("", displayMode: .inline).navigationBarTitle("Appointments")
            }
            .tabItem {
                Text("Appointments")
                Image(systemName: "calendar.circle")
            }
            .tag("Appointment")
      
            
            if (session.session != nil ){
                NavigationView{
                ProfileView().navigationBarTitle("Profile", displayMode: .inline)
                }
                    .tabItem {
                        Text("Profile")
                        Image(systemName: "person.crop.circle")
                            
                }.tag("Profile").accessibility(identifier: "ProfileTab")
            }
        }
        .environmentObject(tabswitch)
        .accentColor(Color("PrimaryBlue")) 
    }
}


//            if (session.session != nil ){
//                NavigationView{
//                //ProfileView().navigationBarTitle("Profile", displayMode: .inline)
//                    Text("Signed in -- profile")
//                }
//                    .tabItem {
//                        Text("Profile")
//                        Image(systemName: "person.crop.circle")
//
//                }.tag(4).accessibility(identifier: "ProfileTab")
//
//
//            }
//            if (session.session == nil)  {
//                SignUpView()
//                    .tabItem {
//                        Text("Profile")
//                        Image(systemName: "person.crop.circle")
//                }.tag(5)
//            }
            
            
//            Group{
//                if (session.session != nil ){
//                    //NavigationView{
//                        //ProfileView().navigationBarTitle("", displayMode: .inline)
//
//
//                    NavigationView{
//                        Text("Signed in")
//                            .navigationViewStyle(StackNavigationViewStyle())
//                    }
//
//                    //}
//                    .tabItem {
//                        Text("Profile")
//                        Image(systemName: "person.crop.circle")
//
//                    }
//
//                }
//                else  {
//                    SignUpView()
//                        .tabItem {
//                            Text("Profile")
//                            Image(systemName: "person.crop.circle")
//                        }
//                }
//            }.tag("Profile")


