//
//  ProfileTableViewCell.swift
//  FriscoTV+
//
//  Created by Andrea Jimenez on 10/6/23.
//

import UIKit
import SwiftUI

class ProfileTableViewCell: UITableViewCell {
    
    let icon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "person.fill"))
        return icon
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Account"
        label.textColor = .black
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        addSubview(stackView)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureUI() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

}
