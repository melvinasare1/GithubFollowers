//
//  GhItemInfoView.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 12/02/2021.
//

import UIKit

enum ItemInfoType {
    case repos, gist, followers, following
}

class GhItemInfoView: UIView {

    private let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel = GhTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel = GhTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repos"
            break
        case .followers:
            symbolImageView.image = UIImage(systemName: "heart")
            titleLabel.text = "Followers"
            break
        case .following:
            symbolImageView.image = UIImage(systemName: "person")
            titleLabel.text = "Following"
            break
        case .gist:
            symbolImageView.image = UIImage(systemName: "scribble")
            titleLabel.text = "Public Gists"
            break
        }
        countLabel.text = String(count)
    }
}

private extension GhItemInfoView {
    func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)

        symbolImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        symbolImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        symbolImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 6).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
}
