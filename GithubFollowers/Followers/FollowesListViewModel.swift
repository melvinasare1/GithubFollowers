//
//  FollowesListViewModel.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 13/01/2021.
//

import Foundation

class FollowersListViewModel {

    public var followers: [Followers] = []

    func fetchFollowers(username: String, page: Int, completion: @escaping ([Followers]) -> Void) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] followers, _ in
            guard let ghFollowers = followers else { return }
            self?.followers = ghFollowers
            completion(ghFollowers)
        }
    }
}
