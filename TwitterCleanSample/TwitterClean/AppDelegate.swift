//
//  AppDelegate.swift
//  TwitterClean
//
//  Created by Ravi Prakash Sahu on 20/01/20.
//  Copyright © 2020 Ravi Prakash Sahu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navVC = UINavigationController(rootViewController: SearchTweetConfiguration.setup(searchClient: TWSearchClient.init(authString: Constants.authString)))
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

