//
//  InfoViewController.swift
//  Navigation
//
//  Created by new owner on 05.02.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private let goBackButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 150 , y: 400, width: 180, height: 50))
        button.setTitle("Отправляемся назад", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupButton()
    }

    private func setupButton() {
        view.addSubview(goBackButton)
        goBackButton.center = view.center
        goBackButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }

    @objc private func backAction() {
        let alert = UIAlertController(title: "Вернуться назад", message: "Вы уверены ?!", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "Выйти", style: .default) {_ in
            self.dismiss(animated: true)
            print("Cейчас пользователь будет перенапрвлен на предыдущий экран")
        }
        let cancelAlert = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(cancelAlert)
        alert.addAction(okAlert)
        present(alert, animated: true)
    }
}

