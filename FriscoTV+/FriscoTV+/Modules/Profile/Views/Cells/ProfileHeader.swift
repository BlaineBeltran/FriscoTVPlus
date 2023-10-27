//
//  ProfileHeaderTableViewCell.swift
//  FriscoTV+
//
//  Created by Andrea Jimenez on 10/6/23.
//

import UIKit
import SwiftUI

class ProfileHeader: UITableViewHeaderFooterView {
    
    let profilePicture: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profilePicture1"))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let name: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "First"
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    let joinedLabel: UILabel = {
        let joinedLabel = UILabel()
        joinedLabel.text = "joined 2023"
        joinedLabel.font = .preferredFont(forTextStyle: .caption1)
        joinedLabel.textColor = .secondaryLabel
        return joinedLabel
    }()
    
    let editButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.configuration?.title = "Edit"
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(profilePicture)
        addSubview(stackView)
        addSubview(editButton)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureContents() {
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(joinedLabel)
        NSLayoutConstraint.activate([
            profilePicture.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            profilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profilePicture.heightAnchor.constraint(equalToConstant: 60),
            profilePicture.widthAnchor.constraint(equalToConstant: 60),
            stackView.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 20),
            editButton.heightAnchor.constraint(equalToConstant: 45),
            editButton.widthAnchor.constraint(equalToConstant: 60),
            editButton.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

struct ProfileHeaderRepresdentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        ProfileHeader()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
}

struct ProfileHeader_Preview: PreviewProvider {
    static var previews: some View {
        ProfileHeaderRepresdentable()
            .frame(width: 300, height: 80)
            .previewLayout(.sizeThatFits)
    }
}

