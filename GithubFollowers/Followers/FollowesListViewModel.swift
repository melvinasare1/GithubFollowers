//
//  FollowesListViewModel.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 13/01/2021.
//

import Foundation

class FollowersListViewModel {

    public var followers: [Followers] = []
    public var filterFollowes: [Followers] = []
    public var isSearching = false
    public var hasMoreFollowers = true
    public var page = 1

    func fetchFollowers(username: String, page: Int, completion: @escaping ([Followers]) -> Void) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] githubFollowers in
            guard let self = self else { return }
            self.followers = githubFollowers
            completion(self.followers)
        }
    }

}
