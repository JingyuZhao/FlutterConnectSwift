//
//  AppDelegate.swift
//  FlutterConnectSwift
//
//  Created by zhaojingyu on 2019/11/27.
//  Copyright © 2019 zhaojingyu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = UINavigationController.init(rootViewController: ViewController.init())
        self.window?.makeKeyAndVisible()
        return true
    }


}

