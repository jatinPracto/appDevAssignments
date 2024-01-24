//
//  AddExpenseView.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import Foundation
import UIKit

class AddExpenseView: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    private let cacheManager: CacheManager
    private var addExpenseViewModel: AddExpenseViewModel

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let amountField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Amount"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let typePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private let categoryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Expense", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(cacheManager: CacheManager) {
        self.cacheManager = cacheManager
        self.addExpenseViewModel = AddExpenseViewModel(cacheManager: cacheManager)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Expense"
        view.backgroundColor = .white

        setupUI()
        setupPickers()
    }

    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InputTableViewCell.self, forCellReuseIdentifier: InputTableViewCell.identifier)

        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])

        submitButton.addTarget(self, action: #selector(addExpenseButtonTapped), for: .touchUpInside)
    }

    private func setupPickers() {
        typePickerView.dataSource = self
        typePickerView.delegate = self

        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Three rows in the first section: one for Amount, one for Type, and one for Category
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell

        switch indexPath.row {
        case 0:
            cell.configure(title: "Amount", placeholder: "Enter amount", keyboardType: .decimalPad)
            cell.inputTextField.inputView = amountField
        case 1:
            cell.configure(title: "Type", placeholder: "Select type", keyboardType: .default)
            cell.inputTextField.inputView = typePickerView
        case 2:
            cell.configure(title: "Category", placeholder: "Select category", keyboardType: .default)
            cell.inputTextField.inputView = categoryPickerView
        default:
            break
        }

        return cell
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case typePickerView:
            return TransactionType.allCases.count
        case categoryPickerView:
            return Category.allCases.count
        default:
            return 0
        }
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case typePickerView:
            return TransactionType.allCases[row].rawValue
        case categoryPickerView:
            return Category.allCases[row].rawValue
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case typePickerView:
            let typeCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? InputTableViewCell
            typeCell?.inputTextField.text = TransactionType.allCases[row].rawValue
        case categoryPickerView:
            let categoryCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? InputTableViewCell
            categoryCell?.inputTextField.text = Category.allCases[row].rawValue
        default:
            break
        }
    }

    // MARK: - Actions

    @objc private func addExpenseButtonTapped() {
        guard let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? InputTableViewCell,
              let typeCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? InputTableViewCell,
              let categoryCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? InputTableViewCell,
              let amountText = amountCell.inputTextField.text,
              let typeText = typeCell.inputTextField.text,
              let categoryText = categoryCell.inputTextField.text else {
            // Handle invalid input
            return
        }

        // Get the selected values
        guard let amount = Double(amountText),
              let type = TransactionType(rawValue: typeText),
              let category = Category(rawValue: categoryText) else {
            // Handle invalid input
            return
        }

        addExpenseViewModel.addExpense(amount: amount, type: type, category: category)

        // Reset input fields
        resetInputs()
    }

    private func resetInputs() {
        guard let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? InputTableViewCell,
              let typeCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? InputTableViewCell,
              let categoryCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? InputTableViewCell else {
            return
        }

        amountCell.inputTextField.text = ""
        typeCell.inputTextField.text = ""
        categoryCell.inputTextField.text = ""
    }
}



