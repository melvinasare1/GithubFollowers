//
//  FavouritesViewModel.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 02/04/2021.
//

import Foundation

class FavouritesViewModel {

    public var favourites: [Followers] = []

    func removeFavurites(favourite: Followers, actionType: PersistenceActionType) {
        PersistenceManager.updateWith(favourite: favourite, actionType: actionType) { _ in }
    }
}
