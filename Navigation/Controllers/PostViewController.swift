//
//  PostViewController.swift
//  Navigation
//
//  Created by new owner on 05.02.2023.
//

import UIKit

final class PostViewController: UIViewController {

    private var myPost: String?

    init(myPost: String? = nil) {
        self.myPost = myPost
        super.init(nibName: nil, bundle: nil)
        title = myPost
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = myPost
        makeItemBar()
    }

    private func makeItemBar() {
        let barItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(barItemAction))
        navigationItem.rightBarButtonItem = barItem
    }

    @objc private func barItemAction() {
        let infoVC = InfoViewController()
        infoVC.title = "Information"
        present(infoVC, animated: true)
    }
}

