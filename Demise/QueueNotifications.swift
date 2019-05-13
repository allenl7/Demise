//
//  QueueNotifications.swift
//  Mortality
//
//  Created by Allen Lai on 1/26/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import Foundation
import UserNotifications

struct QueueNotifications {
    
    static let fullFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm Z"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    static let dateTimeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
    //    let someDateTime = formatter.date(from: "2016/10/08 22:31")
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    static let timeZoneFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "Z"
        return formatter
    }()
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    static let userTimeZone: String = {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "Z"
        return formatter.string(from: date)
    }()

    

    static func addTodaysNotifications() {
        // find the time of the day and
        let date = Date()
        let hoursLeft: Double = Double(22 - Int(hourFormatter.string(from: date))!)
        var numberOfNotifications: Int = Int(hoursLeft / 2.5)
        if numberOfNotifications > 5 {
            numberOfNotifications = 5
        }
        var selectedHours = Set<String>()
        while selectedHours.count < numberOfNotifications {
            var triggerDate = getRandomTime(date: Date())
            while (triggerDate > Date()) {
                triggerDate = getRandomTime(date: Date())
            }
            if !selectedHours.contains(hourFormatter.string(from: triggerDate)) {
                selectedHours.insert(hourFormatter.string(from: triggerDate))
                ALLocalNotifications.scheduleLocalNotification(title: "Reminder", body: "Your days are numbered. Swipe to see the quote...", date: triggerDate)
            }
        }
    }
    
    static func addThatDaysNotifications(date: Date) {
        var selectedHours = Set<String>()
        var selectedDates: [Date] = []
//        while selectedHours.count < 8 {
        while selectedHours.count < 5 {
            let triggerDate = getRandomTime(date: date)
            if !selectedHours.contains(hourFormatter.string(from: triggerDate)) {
                selectedHours.insert(hourFormatter.string(from: triggerDate))
                selectedDates.append(triggerDate)
            }
        }
        selectedDates = selectedDates.sorted()
        for date in selectedDates {
            ALLocalNotifications.scheduleLocalNotification(title: "Reminder", body: "Your days are numbered. Swipe to see the quote...", date: date)
        }


    }
    
    static func getRandomTime(date: Date) -> Date {
        let dateString = dateFormatter.string(from: date)
        let randomTimeString = randomtimeFrom8AMTo10PM()
        let fullDateString = dateString + " " + randomTimeString + " " + userTimeZone
        let triggerDate = fullFormatter.date(from: fullDateString)!
        return triggerDate
    }
    
    
    static func randomtimeFrom8AMTo10PM() -> String {
        return randomHour() + ":" + randomNumberFrom0to60()
    }
    
    static func randomHour() -> String {
        let hourInt = randomInt(min: 8, max: 21)
        if hourInt < 10 {
            return "0" + String(hourInt)
        }
        return String(hourInt)
    }

    static func randomNumberFrom0to60() -> String {
        let randNumber = Int(arc4random_uniform(60))
        if randNumber < 10 {
            return "0" + String(randNumber)
        }
        return String(randNumber)
    }
    static func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
}








