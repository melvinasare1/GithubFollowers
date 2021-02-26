//
//  EmptyState.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 06/02/2021.
//

import UIKit

class GhEmptyState: UIView {

    let messageLabel = GhTitleLabel(textAlignment: .center, fontSize: 28)

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "empty-state-logo-dark")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setup()
    }
}

private extension GhEmptyState {
    func setup() {
        addSubview(messageLabel)
        addSubview(imageView)

        messageLabel.numberOfLines  = 3
        messageLabel.textColor = .secondaryLabel
        
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true

        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170).isActive = true
    }
}
