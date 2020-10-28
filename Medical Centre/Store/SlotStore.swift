import Foundation
import SwiftUI

class SlotStore: ObservableObject{
   @Published var availableSlots : [Slot] = []
    let slotRepo = SlotRepo()
    
    func populateAvailableSlotsForSelectedDate(date: Date, resourceId: String) {
        slotRepo.getAvailableSlots(resourceID: resourceId, date: date, projectID: "d27ccfcf-d050-4e64-bc93-fe3add62f8f3"){ [self] slots in
            DispatchQueue.main.async {
                if let slots = slots {
                    self.availableSlots = slots
                }
            }
        }
    }
}

