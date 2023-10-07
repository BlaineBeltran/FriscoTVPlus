//
//  Coordinating.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/7/23.
//

import UIKit

protocol Coordinating: AnyObject {
    var childCoordinators: [Coordinating] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
