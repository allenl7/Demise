//
//  BlankViewController.swift
//  Demise
//
//  Created by Allen Lai on 1/29/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import UIKit
import UserNotifications

class BlankViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // set initialViewController
        var initialViewController: UIViewController!
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            if settings.authorizationStatus == .authorized {
                // show the regular screen
                let sb = UIStoryboard(name: "Main", bundle: .main)
                initialViewController = sb.instantiateInitialViewController()!
            } else {
                // Show welcome screen
                let sb = UIStoryboard(name: "Welcome", bundle: .main)
                initialViewController = sb.instantiateInitialViewController()!
            }
            
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate

                appDelegate.window?.rootViewController = initialViewController
                appDelegate.window?.makeKeyAndVisible()
            }
        }


    
    
    
    
    
    }


    
    

}
