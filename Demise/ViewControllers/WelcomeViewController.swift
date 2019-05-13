//
//  WelcomeViewController.swift
//  Mortality
//
//  Created by Allen Lai on 1/16/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import UIKit
import UserNotifications

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var enableNotificationButton: UIButton!
    var didNotEnable: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearNavBar()

    }

    @IBAction func enableNotificationButtonTapped(_ sender: Any) {
        if didNotEnable {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let nav = storyboard.instantiateInitialViewController()!
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = nav
            appDelegate.window?.makeKeyAndVisible()
            return
        }
        
        self.requestAuthorization(completionHandler: { (success) in
            guard success else {
                // show a button to contineu to the app without notifications
                self.didNotEnable = true
                UserDefaults.standard.set(self.didNotEnable, forKey: "notificationsNotEnabled")
                return
            }
            
            DispatchQueue.main.async {
                // segue to Main screen
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let nav = storyboard.instantiateInitialViewController()!
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = nav
                appDelegate.window?.makeKeyAndVisible()
            }
        })
    }

    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    func clearNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
}



