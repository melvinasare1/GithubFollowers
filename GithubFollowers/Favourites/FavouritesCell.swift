//
//  FavouritesCell.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 23/02/2021.
//

import UIKit

class FavouritesCell: UITableViewCell {

    private let ghAvatarView: GhAvatarView = {
        let imageView = GhAvatarView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let usernameLabel = GhTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favourite: Followers) {
        usernameLabel.text = favourite.login
        ghAvatarView.downloadImage(from: favourite.avatar_url)
    }
}

private extension FavouritesCell {
    func setup() {
        addSubview(ghAvatarView)
        addSubview(usernameLabel)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        ghAvatarView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ghAvatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        ghAvatarView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ghAvatarView.widthAnchor.constraint(equalToConstant: 60).isActive = true

        usernameLabel.centerYAnchor.constraint(equalTo: ghAvatarView.centerYAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: ghAvatarView.trailingAnchor, constant: 24).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
