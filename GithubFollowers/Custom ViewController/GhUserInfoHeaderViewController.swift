//
//  GhUserInfoHeaderViewController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 16/01/2021.
//

import UIKit

class GhUserInfoHeaderViewController: UIViewController {
    
    private let avatarView: GhAvatarView = {
        let imageView = GhAvatarView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let usernameLabel = GhTitleLabel(textAlignment: .left, fontSize: 30)
    let nameLabel = GhSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GhSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GhBodyLabel(textAlignment: .left)
    
    var user: User!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {

        avatarView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: "location")
        locationImageView.tintColor = .secondaryLabel
    }

    func addSubviews() {
        view.addSubview(avatarView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
}

private extension GhUserInfoHeaderViewController {

    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 90).isActive = true

        usernameLabel.topAnchor.constraint(equalTo: avatarView.topAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: textImagePadding).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 38).isActive = true

        nameLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: textImagePadding).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        locationImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor).isActive = true
        locationImageView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: textImagePadding).isActive = true
        locationImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locationImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        bioLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: textImagePadding).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        bioLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
