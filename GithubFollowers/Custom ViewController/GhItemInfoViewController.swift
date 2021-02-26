//
//  GhItemInfoViewController.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 12/02/2021.
//

import UIKit

class GhItemInfoViewController: UIViewController {

    public weak var delegate: UserProfileViewControllerDelegate?

    private let stackview: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let itemInfoViewOne: GhItemInfoView = {
        let infoView = GhItemInfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    public let itemInfoViewTwo: GhItemInfoView = {
        let infoView = GhItemInfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    public let actionButton: GhButton = {
        let button = GhButton()
        button.configure(buttonText: "Get Started", textColor: .white, backgroundColors: .systemBlue)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func actionButtonTapped() {
        print("test")
    }
    
    var user: User?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension GhItemInfoViewController {
    func setup() {
        view.addSubview(stackview)
        view.addSubview(actionButton)
        
        stackview.addArrangedSubview(itemInfoViewOne)
        stackview.addArrangedSubview(itemInfoViewTwo)
        
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        
        let padding: CGFloat = 20
        stackview.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        stackview.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
    }
}
