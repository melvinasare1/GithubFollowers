//
//  GhBodyLabel.swift
//  GithubFollowers
//
//  Created by melvin asare on 16/01/2021.
//

import UIKit

class GhBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        font =  UIFont.systemFont(ofSize: 16, weight: .regular)
        minimumScaleFactor = 0.75
        translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAlignment
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        numberOfLines = 0
    }
}
