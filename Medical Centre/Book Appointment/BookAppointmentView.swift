//
//  BookAppointmentView.swift
//  Medical Centre
//
//  Created by aidan egan on 16/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import SwiftUI
import ExyteGrid

struct BookAppointmentView: View {
    @ObservedObject var slot = SlotStore()
    
    var body: some View {
        VStack{
            MonthlyCalendarView1(
            initialMonth: Date())
            Grid(tracks: 4){
                ForEach(slot.availableSlots, id: \.self) { timeSlot in
                    Text(timeSlot.formattedStartTime).foregroundColor(Color("PrimaryBlue")).padding(2)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("PrimaryBlue"), lineWidth: 1))
                }
            }
        }
    }
}

//struct BookAppointmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookAppointmentView()
//    }
//}
