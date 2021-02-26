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

    enum Keys {
        static let favourites = "favourites"
    }

    static func updateWith(favourite: Followers, actionType: PersistenceActionType, completion: @escaping(GhError?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success(var favourites):

                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completion(.alreadyInFavourites)
                        return
                    }
                    favourites.append(favourite)
                case .remove:
                    favourites.removeAll { $0.login == favourite.login }
                }
                completion(save(favourites: favourites))

            case .failure(let error):
                completion(error)
            }
        }
    }

    static func retrieveFavourites(completion: @escaping (Result<[Followers], GhError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Followers].self, from: favouritesData)
            completion(.success(favourites))
        } catch {
            completion(.failure(.unableToAddToFavourites))
        }
    }

    static func save(favourites: [Followers]) -> GhError? {
        do {
            let enconder = JSONEncoder()
            let encoderFavourites = try enconder.encode(favourites)
            defaults.set(encoderFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToAddToFavourites
        }
    }
}
