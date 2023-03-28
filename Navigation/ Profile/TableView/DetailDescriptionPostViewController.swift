//
//  DetailDescriptionPostViewController.swift
//  Navigation
//
//  Created by new owner on 20.03.2023.
//

import UIKit

class DetailDescriptionPostViewController: UIViewController {
    
    var post: Post
    
    var handler: ((Int) -> Void)
    
    private lazy var detailDescriptionPostView = DetailDescriptionPostView(post: post)
    
    init(post: Post, handler: @escaping (Int) -> ()) {
        self.post = post
        self.handler = handler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailDescriptionPostView)
        detailDescriptionPostView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailDescriptionPostView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailDescriptionPostView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailDescriptionPostView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailDescriptionPostView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        handler(1)
    }
}
