//
//  BeautySalonDetailCoordinator.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautySalonDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var beautyProviderID: Int
    
    init(navigationController: UINavigationController, beautyProviderID: Int) {
        self.navigationController = navigationController
        self.beautyProviderID = beautyProviderID
    }
    
    func start() {
        let beautySalonDetailViewController = BeautySalonDetailViewController.instantiate(storyboardName: "BeautySalonDetail")
        beautySalonDetailViewController.coordinator = self
        beautySalonDetailViewController.viewModel = BeautySalonDetailViewModel(beautyProviderID: beautyProviderID, beautySalonListDataService: BeautySalonListDataService())
        beautySalonDetailViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(beautySalonDetailViewController, animated: true)
    }
    
    func showBeautyProviderOnMap(beautyProviderLocation: BeautyProviderLocation) {        
        let beautySalonMapViewController = BeautySalonMapViewController.instantiate(storyboardName: "BeautySalonDetail")
        beautySalonMapViewController.viewModel = BeautySalonMapViewModel(beautyProviderLocation: beautyProviderLocation)
        navigationController.pushViewController(beautySalonMapViewController, animated: true)
    }
}
