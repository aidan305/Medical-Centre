//
//  DateHelper.swift
//  Medical Centre
//
//  Created by aidan egan on 22/09/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

class DateHelper{
    func convertDateStringToUserReadableString(timestamp: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+01:00"//this your string date format
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let convertedDate = dateFormatter.date(from: timestamp)
        
        dateFormatter.dateFormat = "EEEE dd-MMM"///this is what you want to convert format
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    
    func convertDateStringToUserReadableTimeString(timestamp: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+01:00"//this your string date format
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let convertedDate = dateFormatter.date(from: timestamp)
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        dateFormatter.dateFormat = "HH:mm a"///this is what you want to convert format
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    
    func convertAppointmentDateToString(appointmentDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd-MMM"///this is what you want to convert format
        let dateStringToReturn = dateFormatter.string(from: appointmentDate)

        return dateStringToReturn
    }
    
    func convertDateToString(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd "
        let dateToReturn = df.string(from: date)
        return dateToReturn
    }
    
    func convertStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'"
        let date = dateFormatter.date(from:date)!
        return date
    }
    
    func convertFirebaseStoredStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+01:00"//this your string date format
        let convertedDate = dateFormatter.date(from: date) ?? Date()
        return convertedDate
    }
    
    
    func convertDateToUserReadableString(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        let dateToReturn = df.string(from: date)
        return dateToReturn
    }
    
    func isDateStringInTheFuture(appointmentDateString: String) -> Bool {
        
        var isUpcoming : Bool = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+01:00"//this your string date format
        let convertedAppointmentDate = dateFormatter.date(from: appointmentDateString)
        
        if let appointmentDate = convertedAppointmentDate{
            if appointmentDate < Date()  { // is appointment date in the past
                isUpcoming = false
            }
        }
        return isUpcoming
    }
}
