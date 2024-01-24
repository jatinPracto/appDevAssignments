////
////  CategoryPickerTableViewCell.swift
////  ExpenseTrackerApp
////
////  Created by Jatin Kamal Vangani on 22/01/24.
////
//
//import Foundation
//import UIKit
//class CategoryPickerTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
//    static let identifier = "CategoryPickerTableViewCell"
//
//    let categoryPicker: UIPickerView = {
//        let picker = UIPickerView()
//        picker.translatesAutoresizingMaskIntoConstraints = false
//        return picker
//    }()
//
//    var categories: [Category] = []
//
//    var selectedCategory: Category?
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        contentView.addSubview(categoryPicker)
//        categoryPicker.dataSource = self
//        categoryPicker.delegate = self
//
//        NSLayoutConstraint.activate([
//            categoryPicker.topAnchor.constraint(equalTo: contentView.topAnchor),
//            categoryPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            categoryPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            categoryPicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//
//    func configure(categories: [Category]) {
//        self.categories = categories
//        categoryPicker.reloadAllComponents()
//        selectedCategory = categories.first
//    }
//
//    // MARK: - UIPickerViewDataSource
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return categories.count
//    }
//
//    // MARK: - UIPickerViewDelegate
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return categories[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedCategory = categories[row]
//    }
//}
