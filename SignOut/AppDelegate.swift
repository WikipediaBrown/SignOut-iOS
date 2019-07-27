//
//  AppDelegate.swift
//  SignOut
//
//  Created by Wikipedia Brown on 7/27/19.
//  Copyright © 2019 IamGoodBad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ScanViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

