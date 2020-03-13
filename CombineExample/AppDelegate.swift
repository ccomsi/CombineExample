//
//  AppDelegate.swift
//  CombineExample
//
//  Created by KIM JUNG HWAN on 2019/12/17.
//  Copyright © 2019 KIM JUNG HWAN. All rights reserved.
//

import AsyncDisplayKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let feedNavigationController = ASNavigationController(rootViewController: FeedViewController())
        feedNavigationController.tabBarItem.title = "Feed"
        
        let searchNavigationController = ASNavigationController(rootViewController: SearchViewController())
        searchNavigationController.tabBarItem.title = "Search"
        
        let tabBarController = ASTabBarController()
        tabBarController.viewControllers = [feedNavigationController, searchNavigationController]
        
        tabBarController.selectedIndex = 1

        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true  
    }
}

