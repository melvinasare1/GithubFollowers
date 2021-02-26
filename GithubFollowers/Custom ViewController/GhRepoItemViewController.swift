//
//  GhRepoItemViewController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 17/02/2021.
//

import Foundation

class GhRepoItemViewController: GhItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func actionButtonTapped() {
        delegate?.didTapGithubProfileButton(for: user!)
    }
}

private extension GhRepoItemViewController {
    private func setup() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user!.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gist, withCount: user!.publicGists)
        actionButton.backgroundColor = .systemPurple
        actionButton.setTitle("Github Profile", for: .normal)
        actionButton.isUserInteractionEnabled = true
    }
}
