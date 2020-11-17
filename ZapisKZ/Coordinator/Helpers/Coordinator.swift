//
//  Coordinator.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
