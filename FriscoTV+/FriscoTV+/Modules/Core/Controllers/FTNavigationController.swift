//
//  FTNavigationController.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/9/23.
//

import UIKit

/// Custom navigation controller to give control of the status bar style to the view controller
class FTNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        visibleViewController
    }
}
