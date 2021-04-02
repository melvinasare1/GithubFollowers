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
    private var viewModel: FavouritesViewModel

    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let favourites):
                self.updateUI(with: favourites)

            case .failure( _):
                self.presentAlert(title: "error", message: "error")
            }
        }
    }

    func updateUI(with favourites: [Followers]) {
        if favourites.isEmpty {
            self.showEmptyStateView(message: "No Favorites?\nAdd one on the follower screen.", in: self.view)
        } else  {
            self.viewModel.favourites = favourites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }

    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavorites()
    }
}

extension FavouritesViewController {

    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavouritesCell)!
        let favourite = self.viewModel.favourites[indexPath.row]
        cell.set(favourite: favourite)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favourites.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = viewModel.favourites[indexPath.row]
        let destinationViewController = FollowersListViewController(viewModel: FollowersListViewModel())
        destinationViewController.usernameLabel.text = favourite.login
        destinationViewController.titleLabel.text = favourite.login

        navigationController?.pushViewController(destinationViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let favourite = self.viewModel.favourites[indexPath.row]
        self.viewModel.favourites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)

        self.viewModel.removeFavurites(favourite: favourite, actionType: .remove)
    }
}

private extension FavouritesViewController {
    func setup() {
        view.backgroundColor = .white
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
    }
}
