//
//  GhButton.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 11/01/2021.
//

import UIKit

class GhButton: UIButton {

    func configure(buttonText: String, textColor: UIColor, backgroundColors: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textAlignment = .center
        setTitleColor(textColor, for: .normal)
        setTitle(buttonText, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        backgroundColor = backgroundColors
        layer.cornerRadius = 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GhButton {
    func setup() {
        topAnchor.constraint(equalTo: topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
