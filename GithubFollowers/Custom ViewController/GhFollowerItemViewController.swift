//
//  GhFollowerItemViewController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 17/02/2021.
//

import Foundation

class GhFollowerItemViewController: GhItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func actionButtonTapped() {
        delegate?.didTapGithubFollowersButton(for: user!)
    }
}

private extension GhFollowerItemViewController {
    private func setup() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user!.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user!.following)
        actionButton.backgroundColor = .systemGreen
        actionButton.setTitle("Get Followers", for: .normal)
    }
}
