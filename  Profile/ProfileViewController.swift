//
//  ProfileViewController.swift
//  Navigation
//
//  Created by new owner on 05.02.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

     let profileHeaderView = ProfileHeaderView()

    override func loadView() {
        super.loadView()
        view.addSubview(profileHeaderView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.bounds
    }
}

