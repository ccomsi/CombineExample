//
//  AppDelegate.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2019/12/17.
//  Copyright © 2019 KIM JUNG HWAN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let ASDKNavController = UINavigationController(rootViewController: ASDKViewController())
        ASDKNavController.tabBarItem.title = "ASDK"        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [ASDKNavController]
        tabBarController.selectedIndex = 0

        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

