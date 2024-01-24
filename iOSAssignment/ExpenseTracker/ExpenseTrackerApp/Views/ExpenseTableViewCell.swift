//
//  ExpenseTableViewCell.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    static let identifier = "ExpenseTableViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with expense: Transaction) {
        titleLabel.text = expense.category
        amountLabel.text = "\(expense.amount) \(expense.type)"
    }

}
