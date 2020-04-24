//
//  AppDelegate.swift
//  MVVMSwiftExample
//
//  Created by Dino Bartosak on 25/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let gameLibrary: GameServiceProtocol = InMemoryGameService()
        
        let rootViewController: HomeViewController = window?.rootViewController as! HomeViewController
        rootViewController.gameLibrary = gameLibrary
        
        return true
    }
    
}

