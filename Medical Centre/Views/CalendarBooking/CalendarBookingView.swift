import ElegantCalendar
import SwiftUI
import ExyteGrid

struct CalendarBookingView: View {
    var selectedResourceID : String
    let currentCalendar = Calendar.current
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   ]
    @ObservedObject private var calendarManager: MonthlyCalendarManager
    @ObservedObject var slots = SlotStore()
    @State var buttonTapped = false
    @State var bookingSuccess = false
    @State private var calendarTheme: CalendarTheme = .white
    @State private var selectedSlot = Slot(startTimeStamp: "test", endTimeStamp: "test", formattedStartTime: "test", formattedEndTime: "test", resourceName: "test", resourceID: "test")
        
    init(initialMonth: Date?, selectedResourceID: String) {
        
        func addYearToDate(date: Date) -> Date {
            var dateComponent = DateComponents()
            dateComponent.year = 1
            let dateInOneYear = Calendar.current.date(byAdding: dateComponent, to: date)
            print(dateInOneYear)
            return dateInOneYear!
        }
        let configuration = CalendarConfiguration(calendar: currentCalendar,
                                                  startDate: initialMonth!,
                                                  endDate: addYearToDate(date: initialMonth!))
        calendarManager = MonthlyCalendarManager(configuration: configuration,
                                                 initialMonth: initialMonth)
        self.selectedResourceID = selectedResourceID
        calendarManager.datasource = self
        calendarManager.delegate = self
    }
    
    var body: some View {
        VStack(){
            NavigationLink(destination: BookingConfirmationView(slotBooked: selectedSlot), isActive: $bookingSuccess){ EmptyView()}
            MonthlyCalendarView(calendarManager: calendarManager)
                .horizontal()
                .theme(calendarTheme)
                .frame(width: 320, alignment: .center)
                .padding(.trailing, 50)
                .padding(.top, 2)
                LazyVGrid(columns: columns){
                    ForEach(slots.availableSlots, id: \.self) { timeSlot in
                        Button(action: {
                            self.selectedSlot = timeSlot
                            self.buttonTapped.toggle()
                        }) {
                            if selectedSlot.formattedStartTime == timeSlot.formattedStartTime && buttonTapped == true {
                                Text(timeSlot.formattedStartTime).foregroundColor(Color.white).padding(2)
                                .background(RoundedRectangle(cornerRadius: 5))
                                    .font(.system(size: 13))
                                    .lineLimit(1)
                            } else {
                                Text(timeSlot.formattedStartTime).foregroundColor(Color("PrimaryBlue")).padding(2)
                                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("PrimaryBlue"), lineWidth: 1))
                                    .font(.system(size: 13))
                                    .lineLimit(1)
                            }
                        }
                    }.padding()
                }.frame(width: 320, alignment: .center)
            BookNowButtonView(selectedSlot: $selectedSlot, bookingSuccess: $bookingSuccess)
        }
    }
}


extension CalendarBookingView: MonthlyCalendarDataSource {
    
    func calendar(canSelectDate date: Date) -> Bool {
        if date.getWeekDay().rawValue == 1 || date.getWeekDay().rawValue == 7  {
            return false
        }
        else {
            return true
        }
    }
}

extension CalendarBookingView: MonthlyCalendarDelegate {
    //Step 1) Make api call for available time slots on that date
    //Step 2) Display the available slots
    //Step 3) Collect date and time slot and perform a post to create booking
    //Step 4) Navigate to confirmation screen
    
    func calendar(didSelectDay date: Date) {
        print("Selected date: \(date)")
        slots.populateAvailableSlotsForSelectedDate(date: date, resourceId: selectedResourceID)
    }
    
    func calendar(willDisplayMonth date: Date) {
        print("Will show month: \(date)")
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBookingView(initialMonth: Date(), selectedResourceID: "6db30e22-32ce-41d9-97cb-dbc2aa176c7c")
    }
}
