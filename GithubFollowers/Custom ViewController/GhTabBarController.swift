//
//  GhTabBarController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 25/02/2021.
//

import UIKit

class GhTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemTeal
        viewControllers = [createSearchViewController(), createFavouriteViewController()]
    }

    func createSearchViewController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchViewController)
    }

    func createFavouriteViewController() -> UINavigationController {
        let favouritesViewController = FavouritesViewController(viewModel: FavouritesViewModel())
        favouritesViewController.title = "Favourites"
        favouritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favouritesViewController)
    }

    func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemTeal
        tabBar.viewControllers = [createSearchViewController(), createFavouriteViewController()]
        return tabBar
    }
}
