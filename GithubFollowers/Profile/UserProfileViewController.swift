//
//  UserProfileViewController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 11/02/2021.
//

import UIKit
import SafariServices

protocol UserProfileViewControllerDelegate: class {
    func didTapGithubProfileButton(for user: User)
    func didTapGithubFollowersButton(for user: User)
}

class UserProfileViewController: UIViewController {

    public weak var delegate: FollowersListViewControllerDelegate!

    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let itemViewOne: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let itemViewTwo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    #warning("Remove unused variables")
    public var username: String = {
        let label = String()
        return label
    }()

    public var dateLabel: GhBodyLabel = {
        let label = GhBodyLabel()
        return label
    }()

    @objc func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

     func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    let repoItemViewController = GhRepoItemViewController(user: user)
                    repoItemViewController.delegate = self

                    let followersItemViewController = GhFollowerItemViewController(user: user)
                    followersItemViewController.delegate = self

                    self.add(childViewController: GhUserInfoHeaderViewController(user: user), to: self.headerView)
                    self.add(childViewController: repoItemViewController, to: self.itemViewOne)
                    self.add(childViewController: followersItemViewController, to: self.itemViewTwo)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getUserInfo()
    }
}

private extension UserProfileViewController {

    func setup() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)

        view.backgroundColor = .systemBackground

        let doneButton =  UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem = doneButton

        let padding: CGFloat = 20
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 180).isActive = true

        itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding).isActive = true
        itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        itemViewOne.heightAnchor.constraint(equalToConstant: 140).isActive = true

        itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding).isActive = true
        itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        itemViewTwo.heightAnchor.constraint(equalToConstant: 140).isActive = true

        dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}

extension UserProfileViewController: UserProfileViewControllerDelegate {
    func didTapGithubProfileButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }

    func didTapGithubFollowersButton(for user: User) {
        guard user.followers != 0 else {
            presentAlert(title: "Error", message: "Error")
            return
        }
        delegate.didRequestFollowers(username: user.login)
        dismiss(animated: true, completion: nil)
    }
}
