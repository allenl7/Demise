//
//  ALLocalNotifications.swift
//  Mortality
//
//  Created by Allen Lai on 1/27/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import Foundation
import UserNotifications


struct ALLocalNotifications {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
    
    
    static var numberOfNotifications: Int = 0
    static var lastDate: Date!
    static var onQuoteNumber: Int = 0
    static var notiDates: [Date] = []
    
    static func addLocalNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { (requests) in
            numberOfNotifications = requests.count
            if requests.count == 0 {
                QueueNotifications.addTodaysNotifications()
            }
            if let lastReq = requests.last {
                lastDate = formatter.date(from: lastReq.identifier)
            } else {
                lastDate = Date()
            }
            while (numberOfNotifications < 55) {
                lastDate = lastDate + 1.days
                QueueNotifications.addThatDaysNotifications(date: lastDate)
            }
            //save
            UserDefaults.standard.set(notiDates, forKey: "notificationDates")
        })
    }
    
    
    static func scheduleLocalNotification(title: String, body: String, date: Date) {
        numberOfNotifications = numberOfNotifications + 1

        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.badge = 1

        
        // Add Trigger
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.timeZone], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: formatter.string(from: date), content: notificationContent, trigger: trigger)
        
        let hoursFromGMT: Int = TimeZone.current.secondsFromGMT()/3600
        notiDates.append(date)
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    

    


}
