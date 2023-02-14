//
//  FeedViewController.swift
//  Navigation
//
//  Created by new owner on 05.02.2023.
//

import UIKit

final class FeedViewController: UIViewController {

    private let myPost = Post(title: "My post")

    private let createPostButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 150 , y: 400, width: 150, height: 50))
        button.setTitle("Watch post", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
    }

    private func setupButton() {
        view.addSubview(createPostButton)
        createPostButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)

        createPostButton.translatesAutoresizingMaskIntoConstraints = false
        createPostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createPostButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        createPostButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        createPostButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc func tapAction() {
        let postVC = PostViewController(myPost: myPost.title)
        navigationController?.pushViewController(postVC, animated: true)
    }
}

