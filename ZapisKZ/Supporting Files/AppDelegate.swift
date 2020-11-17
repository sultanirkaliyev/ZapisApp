//
//  AppDelegate.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import YandexMapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupYandexMap()
        
        window = UIWindow()
        coordinator = AppCoordinator(window: window!, initFlow: .tabbar)
        coordinator?.start()
        
        return true
    }
}

extension AppDelegate {
    
    func setupYandexMap() {
        let apiKey = "1e405d70-df8b-4888-9987-5563a91a1719"
        YMKMapKit.setApiKey(apiKey)
    }
}
