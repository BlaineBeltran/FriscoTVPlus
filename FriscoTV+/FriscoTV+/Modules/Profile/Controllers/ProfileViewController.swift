//
//  ViewController.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/5/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 40
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ProfileHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        return tableView
    }()

    private let signOutButton: UIButton = {
        let signOutButton = UIButton(configuration: .tinted())
        signOutButton.configuration?.title = "Sign Out"
        signOutButton.configuration?.baseForegroundColor = .red
        signOutButton.configuration?.baseBackgroundColor = .secondaryLabel
        signOutButton.configuration?.cornerStyle = .medium
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.addTarget(self, action: #selector(presentSignOutAlert), for: .touchUpInside)
        return signOutButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        activateConstraints()
    }

    private func activateConstraints() {
        view.addSubview(tableView)
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -150),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 45),
            signOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signOutButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10)

        ])
    }
    
    @objc
    private func presentSignOutAlert() {
        let title = "Are you sure you want to do this?"
        let message = "This action cannot be undone and all of your account data will be deleted."
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { action in
            NotificationCenter.default.post(name: NSNotification.Name("SIGN OUT"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("User tapped cancel")
        }
        presentAlert(with: title, message: message, actions: [signOutAction, cancelAction])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "person.fill")
        content.text = "Account"
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! ProfileHeader
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
}

extension ProfileViewController {
    func presentAlert(with title: String, message: String, style: UIAlertController.Style = .actionSheet, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
