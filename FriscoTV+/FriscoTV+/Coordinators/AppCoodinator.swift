//
//  AppCoodinator.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/7/23.
//

import UIKit

/// The main coordinator responsible for setting up the initial state of the app
class AppCoordinator: Coordinating {
    var childCoordinators = [Coordinating]()
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print(navigationController.viewControllers)
    }
}
