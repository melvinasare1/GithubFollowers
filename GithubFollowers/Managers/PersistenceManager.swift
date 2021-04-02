//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 18/02/2021.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defaults = UserDefaults.standard
    enum Keys { static let favorites = "favourites" }

    static func updateWith(favourite: Followers, actionType: PersistenceActionType, completed: @escaping (GhError?) -> Void?) {
        retrieveFavorites { result in
            switch result {
            case .success(var favourites):

                switch actionType {
                case .add:

                    guard !favourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    
                    favourites.append(favourite)

                case .remove:
                    favourites.removeAll { $0.login == favourite.login }
                }

                completed(save(favorites: favourites))

            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveFavorites(completed: @escaping (Result<[Followers], GhError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Followers].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToAddToFavourites))
        }
    }

    static func save(favorites: [Followers]) -> GhError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToAddToFavourites
        }
    }
}
