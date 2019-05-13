//
//  SettingsViewController.swift
//  Mortality
//
//  Created by Allen Lai on 1/16/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import Mixpanel

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    
    let messageComposer = MessageComposer()
    let messageComposerShare = MessageComposerShare()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearNavBar()
        
        let scheduler = DLNotificationScheduler()
        scheduler.printAllNotifications()

        let currentCount = UserDefaults.standard.integer(forKey: dateFormatter.string(from: Date() ))
        
        let (minutes, seconds) = Helper.secondsToMinutesSeconds(seconds: currentCount)
        if seconds < 10 {
            timerLabel.text = String(minutes) + ":0" + String(seconds)
        } else {
            timerLabel.text = String(minutes) + ":" + String(seconds)
        }
        
    }
    
    
    @IBAction func textUsButtonTapped(_ sender: Any) {
        if (messageComposer.canSendText()) {

            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            present(messageComposeVC, animated: true, completion: nil)
            
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        Mixpanel.mainInstance().track(event: "Text Us")
        Analytics.logEvent("Text Us", parameters: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        if (messageComposerShare.canSendText()) {
            
            let messageComposeVC = messageComposerShare.configuredMessageComposeViewController()
            present(messageComposeVC, animated: true, completion: nil)
            
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        Mixpanel.mainInstance().track(event: "Share")
        Analytics.logEvent("Share", parameters: nil)

    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func clearNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}
