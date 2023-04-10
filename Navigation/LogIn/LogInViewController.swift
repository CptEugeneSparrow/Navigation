//
//  LogInViewController.swift
//  Navigation
//
//  Created by new owner on 17.02.2023.
//

import UIKit

final class LogInViewController: UIViewController {

    private let notification = NotificationCenter.default

    private lazy var userLogin = "genyaF@protonmail.ru"
    private lazy var userPassword = "xhiu-4Hodr/-datA"

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.masksToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let vKimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoVK")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var emailTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.placeholder = "Email of phone"
        textField.layer.borderWidth = 0.5
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .systemGray6
        textField.tintColor = myColor
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.placeholder = "Password"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .systemGray6
        textField.tintColor = myColor
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false

        let eyeButton = UIButton(type: .custom)
            eyeButton.setImage(UIImage(systemName: "eyebrow"), for: .normal)
            eyeButton.tintColor = .lightGray
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        let eyeContainer = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        eyeContainer.addSubview(eyeButton)
        eyeButton.frame = CGRect(x: -10, y: 0, width: 20, height: 20)

        textField.rightView = eyeContainer
        textField.rightViewMode = .always

        return textField
    }()

    private (set) lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMinXMinYCorner
        ]
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let passwordWarningLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.text = "Пароль должен содержать не менее 16 символов"
        label.alpha = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupStackView()
        setupLogInButton()
        checkLoginButtonStates()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notification.removeObserver(UIResponder.keyboardWillShowNotification)
        notification.removeObserver(UIResponder.keyboardWillHideNotification)
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vKimageView)
        contentView.addSubview(logInButton)
        contentView.addSubview(stackView)
        contentView.addSubview(passwordWarningLabel)
    }

    private func setupStackView() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
    }

    private func checkLoginButtonStates() {
            switch logInButton.state {
            case .normal: logInButton.alpha = 1
            case .selected: logInButton.alpha = 0.8
            case .highlighted: logInButton.alpha = 0.8
            case .disabled: logInButton.alpha = 0.8
            default:
                break
            }
        }

    private func setupLogInButton() {
        logInButton.addTarget(self, action: #selector(tapProfileAction), for: .touchUpInside)
    }

    private func shakeAnimationEmailTextField() {
            let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.1
            shake.repeatCount = 2
            shake.autoreverses = true
            shake.fromValue = NSValue(cgPoint: CGPoint(x: emailTextField.center.x - 5, y: emailTextField.center.y))
            shake.toValue = NSValue(cgPoint: CGPoint(x: emailTextField.center.x + 5, y: emailTextField.center.y))
            emailTextField.layer.add(shake, forKey: "position")
        }

    private func shakeAnimationPasswordTextField() {
             let shake = CABasicAnimation(keyPath: "position")
             shake.duration = 0.1
             shake.repeatCount = 2
             shake.autoreverses = true
             shake.fromValue = NSValue(cgPoint: CGPoint(x: passwordTextField.center.x - 5, y: passwordTextField.center.y))
             shake.toValue = NSValue(cgPoint: CGPoint(x:  passwordTextField.center.x + 5, y:  passwordTextField.center.y))
             passwordTextField.layer.add(shake, forKey: "position")
         }

    private func shakeAnimationPasswordLabel() {
             let shake = CABasicAnimation(keyPath: "position")
             shake.duration = 0.1
             shake.repeatCount = 2
             shake.autoreverses = true
             shake.fromValue = NSValue(cgPoint: CGPoint(x: passwordWarningLabel.center.x - 4,
                                                        y: passwordWarningLabel.center.y))
             shake.toValue = NSValue(cgPoint: CGPoint(x:  passwordWarningLabel.center.x + 4,
                                                      y:  passwordWarningLabel.center.y))
             passwordWarningLabel.layer.add(shake, forKey: "position")
         }

    private func setConstraints() {
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),


            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),


            vKimageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vKimageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vKimageView.widthAnchor.constraint(equalToConstant: 100),
            vKimageView.heightAnchor.constraint(equalToConstant: 100),


            stackView.topAnchor.constraint(equalTo: vKimageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            
            passwordWarningLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            passwordWarningLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: -20),
            passwordWarningLabel.bottomAnchor.constraint(equalTo: logInButton.topAnchor),

            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        ])
    }

    @objc private func tapProfileAction() {
        guard !emailTextField.text!.isEmpty, !passwordTextField.text!.isEmpty else {
            if emailTextField.text!.isEmpty {
                shakeAnimationEmailTextField()
            }
            if passwordTextField.text!.isEmpty {
                shakeAnimationPasswordTextField()
            }
            return
        }
        if passwordTextField.text!.count < 16 {
            passwordWarningLabel.isHidden = false
            shakeAnimationPasswordTextField()
            return
        } else {
            passwordWarningLabel.isHidden = true
        }
        if emailTextField.text == userLogin && passwordTextField.text == userPassword {
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            view.endEditing(true)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keybordSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keybordSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
        }
    }

    @objc func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eyebrow" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero        
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

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
