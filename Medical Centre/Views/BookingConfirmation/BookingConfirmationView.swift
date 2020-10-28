//
//  BookingConfirmationView.swift
//  Medical Centre
//
//  Created by aidan egan on 18/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import Introspect

struct BookingConfirmationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabswitch : TabSwitch
    let slotBooked: Slot
    let dateHelper = DateHelper()
    
    init(slotBooked: Slot){
    UITabBar.appearance().isHidden = true
        self.slotBooked = slotBooked
    }
    
    var body: some View {
        VStack(spacing: 35){
            Image("calendarImage").resizable().frame(width: 200, height: 200)
            Text("You successfully booked an appointment")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("PrimaryBlue"))
            
            VStack{
                Text(slotBooked.resourceName)
                HStack{
                    Text(slotBooked.formattedStartTime)
                    Text("|")
                    Text("\(dateHelper.convertDateStringToUserReadableString(timestamp: slotBooked.startTimeStamp))")
                    
                }.font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.gray)
            }
            Spacer()
            Button(action: {
                tabswitch.tabName = "Home"
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Done").foregroundColor(Color("PrimaryBlue")).bold().frame(width: 300, height: 35)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("PrimaryBlue"), lineWidth: 1))
            }.padding(.bottom, 20)
            
        }.navigationTitle("Booking Confirmation")
        .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
            }
        .navigationBarBackButtonHidden(true)
    }
}


struct BookingConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        BookingConfirmationView(slotBooked: Slot(startTimeStamp: "13:30", endTimeStamp: "14:00", formattedStartTime: "13:30", formattedEndTime: "14:00", resourceName: "Dr. John Smyth", resourceID: "test"))
    }
}
