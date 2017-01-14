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

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = ColorPalette.Grey.Light
        window?.rootViewController = NavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()

        UIApplication.shared.statusBarStyle = .lightContent

        return true
    }
}

