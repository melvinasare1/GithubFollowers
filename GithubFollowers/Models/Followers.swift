//
//  Followers.swift
//  GithubFollowers
//
//  Created by melvin asare on 16/01/2021.
//

import Foundation

struct Followers: Codable {
    let uuid = UUID()

    private enum CodingKeys : String, CodingKey { case login, avatar_url }

    var login: String
    var avatar_url: String
}

extension Followers : Hashable {
    static func ==(lhs: Followers, rhs: Followers) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
