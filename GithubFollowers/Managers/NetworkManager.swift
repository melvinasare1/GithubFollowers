//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by melvin asare on 16/01/2021.
//

import UIKit

class NetworkManager {

    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()

    func getUserInfo(for username: String, completed: @escaping (Result<User, GhError>) -> Void) {
        let endpoint = baseUrl + "\(username)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getFollowers(for username: String, page: Int, completion: @escaping ([Followers]?, String?) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created an invalid request. Please try again.")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "This response is invalid . Please try again.")
                return
            }

            guard let data = data else {
                completion(nil, "This data is invalid. Please try again.")
                return
            }

            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Followers].self, from: data)
                completion(followers, nil)
            } catch {
                
            }
        }
        task.resume()
    }
}
