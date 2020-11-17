//
//  TabBarCoordinator.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: TabBarController
    
    init(navigationController: UINavigationController, tabBarController: TabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        tabBarController.coordinator = self
        
        let beautySalonListNavigationController = UINavigationController()
        beautySalonListNavigationController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home_tab_image"), tag: 0)
        let beautySalonListCoordinator = BeautySalonListCoordinator(navigationController: beautySalonListNavigationController)
        
        tabBarController.viewControllers = [beautySalonListNavigationController]
        tabBarController.tabBar.isTranslucent = false
        
        coordinate(to: beautySalonListCoordinator)
    }
}
