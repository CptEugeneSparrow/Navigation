//
//  LogInViewController.swift
//  Navigation
//
//  Created by new owner on 17.02.2023.
//

import UIKit

final class LogInViewController: UIViewController {
    
    private let notification = NotificationCenter.default
    private var logInView = LogInView()
    
    override func loadView() {
        super.loadView()
        view = logInView
        setupLogInButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Login"
        hideNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notification.removeObserver(UIResponder.keyboardWillShowNotification)
        notification.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    private func setupLogInButton() {
        logInView.logInButton.addTarget(self, action: #selector(tapProfileAction), for: .touchUpInside)
    }
    
    @objc private func tapProfileAction() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keybordSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            logInView.scrollView.contentInset.bottom = keybordSize.height
            logInView.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide() {
        logInView.scrollView.contentInset = .zero
        logInView.scrollView.verticalScrollIndicatorInsets = .zero
        
    }
}

extension LogInViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

