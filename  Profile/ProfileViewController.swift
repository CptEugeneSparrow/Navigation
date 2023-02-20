//
//  ProfileViewController.swift
//  Navigation
//
//  Created by new owner on 05.02.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.layer.cornerRadius = 5
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()

    private (set) lazy var showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func loadView() {
        super.loadView()
        setupViews()
        setConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.bounds
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(profileHeaderView)
        view.addSubview(showStatusButton)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([

            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 230),


            showStatusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showStatusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            showStatusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            showStatusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

