//
//  GhAvatarView.swift
//  GithubFollowers
//
//  Created by melvin asare on 17/01/2021.
//

import UIKit

class GhAvatarView: UIImageView {

    private let cache = NetworkManager.shared.cache

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func downloadImage(from URLString: String) {

        let cacheKey = NSString(string: URLString)

        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }

        guard let url = URL(string: URLString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
                  else { return }
            self?.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }
}

private extension GhAvatarView {
    func setup() {
        addSubview(imageView)

        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
