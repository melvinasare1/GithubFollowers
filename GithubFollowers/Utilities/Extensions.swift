//
//  Extensions.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 06/02/2021.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {

    func presentCustomAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GhAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Done", style: .default) { action in }

        alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
    }

    func showLoadingView() {
        DispatchQueue.main.async { [self] in
            containerView = UIView(frame: self.view.bounds)
            self.view.addSubview(containerView)

            containerView.backgroundColor = .systemBackground
            containerView.alpha = 0

            UIView.animate(withDuration: 0.25) {
                containerView.alpha = 0.8
            }

            let activityIndicator = UIActivityIndicatorView(style: .large)
            containerView.addSubview(activityIndicator)

            activityIndicator.translatesAutoresizingMaskIntoConstraints = false

            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

            activityIndicator.startAnimating()
        }
    }

    func dismissedLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }

    func showEmptyStateView(message: String, in view: UIView) {
        let emptyStateView = GhEmptyState(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
