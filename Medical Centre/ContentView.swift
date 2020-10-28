//
//  ContentView.swift
//  Medical Centre
//
//  Created by aidan egan on 18/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import Introspect

class TabSwitch: ObservableObject{
    @Published var tabName = "Home"
}

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var tabswitch = TabSwitch()
    
    var body: some View {
        Group {
            if (session.session != nil) {
                TabView(){
                    homeTabView
                        .tag("Home")
                    appointmentTabView
                        .tag("Appointment")
                    profileTabView
                        .tag("Profile")
                }
            }
            else {
                TabView(selection: .constant(tabswitch.tabName)){
                    homeTabView
                        .tag("Home")
                    appointmentTabView
                        .tag("Appointment")
                    signUpTabView
                        .tag("Sign Up")
                }
            }
        }.onAppear(perform: getUser)
        .environmentObject(tabswitch)
    }
    
    var homeTabView : some View {
        NavigationView{
            HomeView().navigationBarTitle("", displayMode: .inline)
                .navigationBarTitle("Home")
                .introspectTabBarController { (UITabBarController) in
                    UITabBarController.tabBar.isHidden = false
                }
        }.tabItem {
            Text("Home")
            Image(systemName: "house.fill")
        }
    }
    
    var appointmentTabView : some View {
        NavigationView{
            AppointmentListView().navigationBarTitle("", displayMode: .inline).navigationBarTitle("Appointments")
        }
        .tabItem {
            Text("Appointments")
            Image(systemName: "calendar.circle")
        }
    }
    
    var profileTabView: some View {
        NavigationView{
            ProfileView().navigationBarTitle("Profile", displayMode: .inline)
        }
        .tabItem {
            Text("Profile")
            Image(systemName: "person.crop.circle")
            
        }
    }
    
    var signUpTabView: some View {
        SignUpView()
            .tabItem {
                Text("Sign Up")
                Image(systemName: "person.crop.circle")
            }
    }

    
    func getUser() {
        session.listen()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
