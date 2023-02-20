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
        let logInVC = LogInViewController()

        let navigationFeedVC = UINavigationController(rootViewController: feedVC)
        let navigationLogInVC = UINavigationController(rootViewController: logInVC)

        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "increase.quotelevel")

        logInVC.tabBarItem.title = "Profile"
        logInVC.tabBarItem.image = UIImage(systemName: "figure.wave")

        viewControllers = [navigationFeedVC, navigationLogInVC]
    }
}

