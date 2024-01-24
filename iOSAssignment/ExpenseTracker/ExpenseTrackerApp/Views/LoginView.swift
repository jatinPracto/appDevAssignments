//
//  LoginView.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 23/01/24.
//

import Foundation
import UIKit

class LoginView: UIViewController {

    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter UserName"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            userNameTextField.widthAnchor.constraint(equalToConstant: 200)
        ])

        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 10),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func submitButtonTapped() {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            // Handle case where userName is empty or nil
            return
        }

        let dashboardView = DashboardView(userName: userName)
        navigationController?.pushViewController(dashboardView, animated: true)
    }
}
