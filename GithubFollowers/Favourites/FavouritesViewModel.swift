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
        PersistenceManager.updateWith(favourite: favourite, actionType: actionType) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
        }
    }

}
