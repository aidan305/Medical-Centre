//
//  BookNowButtonView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI

struct BookNowButtonView: View {
    let bookingRepo = BookingRepo()
    @Binding var selectedSlot : Slot
    @Binding var bookingSuccess: Bool
    
    var body: some View {
        Button(action: {
            self.bookingRepo.processBooking(slot: self.selectedSlot) { complete in
                if complete == true {
                    print("booking complete")
                    bookingSuccess = true
                } else {
                    print("booking failed")
                }
            }
        }){
            Text("Book Now").foregroundColor(Color("PrimaryBlue")).bold().frame(width: 300, height: 35)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("PrimaryBlue"), lineWidth: 1))
        }
        .padding(.bottom, 10)
    }
}

