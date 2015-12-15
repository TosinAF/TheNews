//
//  AppDelegate.swift
//  TheNews
//
//  Created by Tosin Afolabi on 7/24/15.
//  Copyright © 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = ColorPalette.Grey.Light
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        return window
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent;
        window?.makeKeyAndVisible()
        return true
    }
}

