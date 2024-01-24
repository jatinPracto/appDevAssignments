//
//  InputTableViewCell.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import Foundation
import UIKit
class InputTableViewCell: UITableViewCell {
    static let identifier = "InputTableViewCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    func configure(title: String, placeholder: String, keyboardType: UIKeyboardType) {
        titleLabel.text = title
        inputTextField.placeholder = placeholder
        inputTextField.keyboardType = keyboardType
    }

    // Add any other configuration methods or properties as needed
}

