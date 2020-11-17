//
//  BeautySalonListCoordinator.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautySalonListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let beautySalonListViewController = BeautySalonListViewController()
        beautySalonListViewController.coordinator = self
        beautySalonListViewController.viewModel = BeautySalonListViewModel(beautySalonListDataService: BeautySalonListDataService())
        navigationController.pushViewController(beautySalonListViewController, animated: true)
    }
    
    func coordinateToBeautyProviderDetail(beautyProviderID: Int) {        
        let beautySalonDetailCoordinator = BeautySalonDetailCoordinator(navigationController: navigationController, beautyProviderID: beautyProviderID)
        coordinate(to: beautySalonDetailCoordinator)
    }
}
