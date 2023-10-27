//
//  AppCoodinator.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/7/23.
//

import UIKit
import SwiftUI

/// The main coordinator responsible for setting up the initial state of the app
class AppCoordinator: Coordinating {
    var childCoordinators = [Coordinating]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        setupWatchNowTab()
        setupLibraryTab()
        setupSearchTab()
        setupProfileTab()
    }
    
    
    private func setupWatchNowTab() {
        let hosting = UIHostingController(rootView: WatchNowCollectionList())
        hosting.tabBarItem = UITabBarItem(title: Constants.home.title, image: UIImage(systemName: "play.circle.fill"), tag: 0)
        let navigationController = FTNavigationController(rootViewController: hosting)
        navigationController.navigationBar.isHidden = true
        tabBarController.addChild(navigationController)
    }
    
    private func setupLibraryTab() {
        let libraryNavigationController = UINavigationController()
        libraryNavigationController.navigationBar.prefersLargeTitles = true
        let libraryViewController = UIViewController()
        libraryViewController.title = Constants.library.title
        libraryViewController.tabBarItem = UITabBarItem(title: Constants.library.title, image: UIImage(systemName: "rectangle.stack.fill"), tag: 1)
        libraryNavigationController.setViewControllers([libraryViewController], animated: false)
        tabBarController.addChild(libraryNavigationController)
    }
    
    private func setupSearchTab() {
        let searchNavigationController = UINavigationController()
        searchNavigationController.navigationBar.prefersLargeTitles = true
        let searchViewController = UIViewController()
        searchViewController.title = Constants.search.title
        searchViewController.tabBarItem = UITabBarItem(title: Constants.search.title, image: UIImage(systemName: "magnifyingglass"), tag: 2)
        searchNavigationController.setViewControllers([searchViewController], animated: false)
        tabBarController.addChild(searchNavigationController)
    }
    
    private func setupProfileTab() {
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: Constants.profile.title, image: UIImage(systemName: "person.fill"), tag: 3)
        tabBarController.addChild(profileViewController)
    }
}
