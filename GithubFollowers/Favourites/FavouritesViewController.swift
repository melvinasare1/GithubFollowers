//
//  FavouritesViewController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 11/01/2021.
//

import UIKit

class FavouritesViewController: UITableViewController {

    private let usernameLabel = GhTitleLabel(textAlignment: .left, fontSize: 26)
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var favourites: [Followers] = []

    fileprivate func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let favourites):
                if favourites.isEmpty {
                    self.showEmptyStateView(message: "No Favourites", in: self.view)
                } else {
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case.failure(let error):
                self.presentAlert(title: error.rawValue, message: "Ok")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavourites()
    }
}

extension FavouritesViewController {

    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavouritesCell)!
        let favourite = favourites[indexPath.row]
        cell.set(favourite: favourite)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        let destinationViewController = FollowersListViewController(viewModel: FollowersListViewModel())
        destinationViewController.usernameLabel.text = favourite.login
        destinationViewController.titleLabel.text = favourite.login

        navigationController?.pushViewController(destinationViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        favourites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)

        PersistenceManager.updateWith(favourite: favourite, actionType: .remove) { [weak self] error in

            guard let self = self else { return }
            guard let error = error else { return }
            self.presentAlert(title: "error", message: error.rawValue)
        }
    }
}

private extension FavouritesViewController {
    func setup() {
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
    }
}
