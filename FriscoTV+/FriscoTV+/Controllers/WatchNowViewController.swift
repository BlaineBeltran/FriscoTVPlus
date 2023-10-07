//
//  WatchNowViewController.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/7/23.
//

import UIKit

class WatchNowViewController: UIViewController {
    typealias Copy = Constants.home

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewController() {
        title = Copy.homeTitle
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
