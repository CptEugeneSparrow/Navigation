//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by new owner on 14.02.2023.
//

import UIKit

final class ProfileTableHeaderView: UIView {

    private let notification = NotificationCenter.default

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

    private lazy var profileTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.placeholder = " Set your status"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
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

    private let transLucentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.frame = UIScreen.main.bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var closeProfileImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()

    private var topConstraintImage = NSLayoutConstraint()
    private var leadingConstraintImage = NSLayoutConstraint()
    private var widthConstraintImage = NSLayoutConstraint()
    private var heightConstraintImage = NSLayoutConstraint()


    private var statusText: String?
    private var key = "key"
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        setupTapGesture()

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
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func tapAction() {
        addSubview(transLucentView)
        addSubview(closeProfileImageButton)
        bringSubviewToFront(userImageView)

        NSLayoutConstraint.activate([
            closeProfileImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            closeProfileImageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            closeProfileImageButton.widthAnchor.constraint(equalToConstant: 30),
            closeProfileImageButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0) {
            self.transLucentView.alpha = 0.5
            self.userImageView.layer.cornerRadius = 0
            self.topConstraintImage.constant = 100
            self.leadingConstraintImage.constant = 0
            self.widthConstraintImage.constant = UIScreen.main.bounds.width
            self.heightConstraintImage.constant = UIScreen.main.bounds.width
            self.layoutIfNeeded()
        }
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.5) {
            self.closeProfileImageButton.alpha = 1
        }
    }

    @objc
    private func cancelAction() {
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [.calculationModeCubicPaced], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.closeProfileImageButton.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                self.userImageView.layer.cornerRadius = 50
                self.topConstraintImage.constant = 16
                self.leadingConstraintImage.constant = 16
                self.widthConstraintImage.constant = 100
                self.heightConstraintImage.constant = 100
                self.transLucentView.alpha = 0
                self.layoutIfNeeded()
            }
        }, completion: nil)
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

extension ProfileTableHeaderView {

    private func saveToStorage(text: String, with key: String) {
        UserDefaults.standard.set(text, forKey: key)
    }

    private func loadFromStorage(by key: String) -> String {
        if let returnText = UserDefaults.standard.string(forKey: key) {
            return returnText
        }
        return " "
    }

    private func setConstraints() {

        topConstraintImage = userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        leadingConstraintImage = userImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        widthConstraintImage = userImageView.widthAnchor.constraint(equalToConstant: 100)
        heightConstraintImage = userImageView.heightAnchor.constraint(equalToConstant: 100)

        NSLayoutConstraint.activate([
            topConstraintImage,
            leadingConstraintImage,
            widthConstraintImage,
            heightConstraintImage,

            profileUserNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            profileUserNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 130),
            profileUserNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),


            statusDescriptionLabel.topAnchor.constraint(equalTo: profileUserNameLabel.bottomAnchor, constant: 16),
            statusDescriptionLabel.leadingAnchor.constraint(equalTo: profileUserNameLabel.leadingAnchor),
            statusDescriptionLabel.trailingAnchor.constraint(equalTo:profileUserNameLabel.trailingAnchor),


            profileTextField.topAnchor.constraint(equalTo: statusDescriptionLabel.bottomAnchor, constant: 8),
            profileTextField.leadingAnchor.constraint(equalTo: profileUserNameLabel.leadingAnchor),
            profileTextField.trailingAnchor.constraint(equalTo: profileUserNameLabel.trailingAnchor),
            profileTextField.heightAnchor.constraint(equalToConstant: 40),


            showStatusButton.topAnchor.constraint(equalTo: profileTextField.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            showStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension ProfileTableHeaderView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

