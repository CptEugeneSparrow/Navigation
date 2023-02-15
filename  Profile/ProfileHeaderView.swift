//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by new owner on 14.02.2023.
//

import UIKit

final class ProfileHeaderView: UIView {

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let profileUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Henry Matisse"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let profileTextField: TextFieldWithPadding = {

        let textField = TextFieldWithPadding()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.placeholder = " Set your status"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private (set) lazy var showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setStatusAction), for: .touchUpInside)
        return button
    }()

    private var statusText: String?
    private var key = "key"

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setConstraints()

        self.statusDescriptionLabel.text = loadFromStorage(by: "somekey")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .lightGray
        addSubview(userImageView)
        addSubview(profileUserNameLabel)
        addSubview(statusDescriptionLabel)
        addSubview(showStatusButton)
        addSubview(profileTextField)
        profileTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }

    @objc
    private func statusTextChanged(_ profileTextField: UITextField) {
        if let text = profileTextField.text {
            statusText = text
        }
    }

    @objc
    private func setStatusAction() {
        self.statusDescriptionLabel.text = self.statusText
        self.profileTextField.text = nil
        self.saveToStorage(text: self.statusText ?? "", with: "somekey")
    }
}

extension ProfileHeaderView {

    private func saveToStorage(text: String, with key: String) {
        UserDefaults.standard.set(text, forKey: key)
    }

    private func loadFromStorage(by key: String) -> String {
        if let returnText = UserDefaults.standard.string(forKey: key) {
            return returnText
        }
        return ""
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            userImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 100),


            profileUserNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileUserNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 20),
            profileUserNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),


            statusDescriptionLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 20),
            statusDescriptionLabel.topAnchor.constraint(equalTo: profileUserNameLabel.bottomAnchor, constant: 5),
            statusDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),


            profileTextField.topAnchor.constraint(equalTo: statusDescriptionLabel.bottomAnchor, constant: 5),
            profileTextField.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 16),
            profileTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileTextField.heightAnchor.constraint(equalToConstant: 40),


            showStatusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            showStatusButton.topAnchor.constraint(equalTo: profileTextField.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            showStatusButton.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 50),
        ])
    }
}


