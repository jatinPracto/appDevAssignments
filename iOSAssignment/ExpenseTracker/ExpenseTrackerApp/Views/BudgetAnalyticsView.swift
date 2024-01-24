//
//  BudgetAnalyticsView.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import UIKit

class BudgetAnalyticsView: UIViewController {

    private let cacheManager: CacheManager
    private let budgetAnalyticsViewModel: BudgetAnalyticsViewModel

    private let totalSpentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let barChartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        stackView.spacing = 8
        return stackView
    }()

    init(cacheManager: CacheManager) {
        self.cacheManager=cacheManager
        self.budgetAnalyticsViewModel = BudgetAnalyticsViewModel(cacheManager: cacheManager)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Budget & Analytics"

        setupUI()
        updateUI()
    }

    private func setupUI() {
        view.addSubview(totalSpentLabel)
        totalSpentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalSpentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            totalSpentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalSpentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        view.addSubview(barChartStackView)
        barChartStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barChartStackView.topAnchor.constraint(equalTo: totalSpentLabel.bottomAnchor, constant: 16),
            barChartStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            barChartStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            barChartStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func updateUI() {
        // Update total spent label
        let totalSpentText = String(format: "Total Spent Monthly: $%.2f", budgetAnalyticsViewModel.totalSpentMonthly)
        totalSpentLabel.text = totalSpentText

        // Update bar chart
        for (category, amount) in budgetAnalyticsViewModel.barChartData {
            let barView = BarChartView(category: category, amount: amount)
            barChartStackView.addArrangedSubview(barView)
        }
    }
}

class BarChartView: UIView {

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    private let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    init(category: String, amount: Double) {
        super.init(frame: .zero)
        setupUI()
        updateUI(category: category, amount: amount)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            barView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func updateUI(category: String, amount: Double) {
        categoryLabel.text = category
        let barHeight = CGFloat(amount) / 10.0  // Adjust scaling as needed
        barView.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
    }
}


