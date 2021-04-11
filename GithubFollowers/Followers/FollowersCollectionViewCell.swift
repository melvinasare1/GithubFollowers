//
//  FollowersCollectionViewCell.swift
//  GithubFollowers
//
//  Created by melvin asare on 17/01/2021.
//

import UIKit

class FollowersCollectionViewCell: UICollectionViewCell {

    private let ghAvatarView: GhAvatarView = {
        let imageView = GhAvatarView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let usernameLabel: GhBodyLabel = {
        let label = GhBodyLabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func configure(with followers: Followers) {
        usernameLabel.text = followers.login

        if !followers.avatar_url.isEmpty {
            ghAvatarView.downloadImage(from: followers.avatar_url)
            
        } else {
            ghAvatarView.image = UIImage(named: "avatar-placeholder-dark")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FollowersCollectionViewCell {
    func setup() {
        addSubview(usernameLabel)
        addSubview(ghAvatarView)

        ghAvatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        ghAvatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        ghAvatarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        ghAvatarView.heightAnchor.constraint(equalTo: ghAvatarView.widthAnchor).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: ghAvatarView.bottomAnchor, constant: 12).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
