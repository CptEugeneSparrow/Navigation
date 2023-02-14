//
//  TabBarController.swift
//  Navigation
//
//  Created by new owner on 05.02.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func loadView() {
        super.loadView()
        setupControllers()
    }

    private func setupControllers() {

        let feedVC = FeedViewController()
        let profileVC = ProfileViewController()

        let navigationFeedVC = UINavigationController(rootViewController: feedVC)
        let navigationProfileVC = UINavigationController(rootViewController: profileVC)

        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "increase.quotelevel")
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "figure.wave")

        viewControllers = [navigationFeedVC, navigationProfileVC]
    }
}

