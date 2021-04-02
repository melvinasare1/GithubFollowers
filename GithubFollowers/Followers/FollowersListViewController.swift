//
//  FollowersListViewController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 13/01/2021.
//

import UIKit

protocol FollowersListViewControllerDelegate: class {
    func didRequestFollowers(username: String)
}

class FollowersListViewController: UIViewController {
    
    public var usernameLabel = GhTitleLabel(textAlignment: .left, fontSize: 14)
    public var titleLabel = GhTitleLabel(textAlignment: .left, fontSize: 36)
    
    private lazy var followersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FollowersCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        return collectionView
    }()

    enum Section {
        case main
    }
    
    private let viewModel: FollowersListViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Followers>!

    func configureCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Followers>(collectionView: followersCollectionView, cellProvider: { (collectionView, indexPath, followers) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FollowersCollectionViewCell
            cell?.configure(with: followers)
            return cell
        })
    }

    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search usernames"
        navigationItem.searchController = searchController
    }
    
    func updateCollectionView(on followers: [Followers]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc func addButtonTapped() {
        showLoadingView()

        NetworkManager.shared.getUserInfo(for: usernameLabel.text!) { [weak self] result in
            self?.dismissedLoadingView()

            switch result {
            case .success(let user):
                self?.addUserToFavourites(user: user)

            case .failure(let error):
                self?.presentAlert(title: error.localizedDescription, message: "error")
            }
        }
    }

    func addUserToFavourites(user: User) {
        let favourite = Followers(login: user.login, avatar_url: user.avatarUrl)

        PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
            guard let self = self else { return }

            guard let error = error else {
                self.presentAlert(title: "yes it worked", message: "yes")
                return
            }
            self.presentAlert(title: "Error", message: "error")
        }
    }

    init(viewModel: FollowersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

private extension FollowersListViewController {
    func setup() {
        view.backgroundColor = .systemBackground

        let addButton =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(usernameLabel)
        view.addSubview(titleLabel)
        view.addSubview(followersCollectionView)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true

        showLoadingView()
        configureCollectionViewDataSource()
        updateCollectionView(on: self.viewModel.followers)
        configureSearchController()
        title = usernameLabel.text

        viewModel.fetchFollowers(username: usernameLabel.text!, page: viewModel.page) { [weak self] followers in
            guard let self = self else { return }
            self.dismissedLoadingView()

            if followers.isEmpty {
                let message = "This user has no more followers"
                DispatchQueue.main.async {
                    self.showEmptyStateView(message: message, in: self.view)
                    return
                }
            }
            self.updateCollectionView(on: self.viewModel.followers)
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = viewModel.isSearching ? viewModel.filterFollowes : viewModel.followers
        let follower = activeArray[indexPath.item]

        let userProfileViewController = UserProfileViewController()
        userProfileViewController.username = follower.login
        userProfileViewController.delegate = self

        let navController = UINavigationController(rootViewController: userProfileViewController)
        present(navController, animated: true)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard viewModel.hasMoreFollowers else { return }
            viewModel.page += 1
            
            viewModel.fetchFollowers(username: usernameLabel.text!, page: viewModel.page) { [weak self] followers in
                guard let self = self else { return }

                guard !followers.isEmpty else { return }
                if followers.count < 100 {
                    self.viewModel.hasMoreFollowers = false
                }
                if followers.isEmpty {
                    let message = "This user has no more followers"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(message: message, in: self.view)
                        return
                    }
                }
                self.viewModel.followers.append(contentsOf: followers)
                self.updateCollectionView(on: followers)
            }
        }
    }
}

extension FollowersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateCollectionView(on: viewModel.followers)
            viewModel.isSearching = false
            viewModel.filterFollowes.removeAll()
            return
        }

        viewModel.isSearching = true
        viewModel.filterFollowes = viewModel.followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateCollectionView(on: viewModel.filterFollowes)
    }
}

extension FollowersListViewController: FollowersListViewControllerDelegate {

    func didRequestFollowers(username: String) {
        self.showLoadingView()
        self.usernameLabel.text = username
        title = username
            viewModel.page = 1

        viewModel.followers.removeAll()
        viewModel.filterFollowes.removeAll()
        followersCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        viewModel.fetchFollowers(username: usernameLabel.text!, page: viewModel.page) { [weak self] followers in
            guard let self = self else { return }
            self.dismissedLoadingView()

            if followers.isEmpty {
                let message = "This user has no more followers"
                DispatchQueue.main.async {
                    self.showEmptyStateView(message: message, in: self.view)
                    return
                }
            }
            self.updateCollectionView(on: self.viewModel.followers)
        }
    }
}
