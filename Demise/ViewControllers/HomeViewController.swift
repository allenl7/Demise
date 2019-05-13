//
//  HomeViewController.swift
//  Mortality
//
//  Created by Allen Lai on 1/16/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import UIKit
import UserNotifications


class HomeViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!

    
    var recordingTimer = Timer()
    var recordingTimeCounter = 0
    
    var currentIterator: Int!
    var currentQuote: Quote! {
        didSet {
            contentLabel.text = currentQuote.content
            autherLabel.text = currentQuote.author
        }
    }
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearNavBar()

        var savedQuoteNumber = UserDefaults.standard.integer(forKey: "onQuoteNumber")
        if var notificationDates = UserDefaults.standard.object(forKey: "notificationDates") as? [Date] {
            notificationDates = notificationDates.sorted()
            let currentDate = Date() + 2.hours
            var datesToSave = notificationDates
            for date in notificationDates {
                if date < currentDate {
                    savedQuoteNumber = savedQuoteNumber + 1
                    datesToSave.removeFirst()
                }
            }
            UserDefaults.standard.set(datesToSave, forKey: "notificationDates")
        }
        
        if savedQuoteNumber >= 99 {
            savedQuoteNumber = savedQuoteNumber - 99
        }
        UserDefaults.standard.set(savedQuoteNumber, forKey: "onQuoteNumber")
        let onQuoteNumber = UserDefaults.standard.integer(forKey: "onQuoteNumber")
        
        currentQuote = Quote.allQuotes[onQuoteNumber]

//        QueueNotifications.addTodaysNotifications()
        ALLocalNotifications.addLocalNotifications()

        recordingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeViewController.updateSceneCounter), userInfo: nil, repeats: true)

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        let currentCount = UserDefaults.standard.integer(forKey: dateFormatter.string(from: Date() ))
        if currentCount == 0 {
            UserDefaults.standard.removeObject(forKey: dateFormatter.string(from: Date() - 1.days ))
            UserDefaults.standard.removeObject(forKey: dateFormatter.string(from: Date() - 2.days ))
        }
        let total = currentCount + recordingTimeCounter
        recordingTimeCounter = 0
        UserDefaults.standard.set(total, forKey: dateFormatter.string(from: Date()))
        
    }
    

    @objc func updateSceneCounter() {
        recordingTimeCounter += 1
    }
    
    
    func clearNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

}





