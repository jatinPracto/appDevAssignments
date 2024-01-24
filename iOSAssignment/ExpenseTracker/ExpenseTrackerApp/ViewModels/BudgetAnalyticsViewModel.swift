//
//  BudgetAnalyticsViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import Foundation

class BudgetAnalyticsViewModel {
    private var cacheManager: CacheManager
    private var expenseList: UserExpenseModel {
        didSet {
            calculateTotalSpent()
            calculateTotalSpentByCategory()
            prepareBarChartData()
        }
    }

    // Total amount spent monthly
    var totalSpentMonthly: Double = 0

    // Total spending based on categories (excluding income)
    var totalSpentByCategory: [Category: Double] = [:]

    // Data for bar chart
    var barChartData: [(category: String, amount: Double)] = []

    init(cacheManager: CacheManager) {
        self.cacheManager = cacheManager

        // Retrieve the user expense model from the cache
        if let cachedModel = cacheManager.getCachedModel() {
            self.expenseList = cachedModel
        } else {
            // If the model is not found, initialize with an empty model
            self.expenseList = UserExpenseModel(userName: "", transaction: [])
        }

        // Additional initialization if needed
        calculateTotalSpent()
        calculateTotalSpentByCategory()
        prepareBarChartData()
    }

    // Calculate total amount spent monthly
    private func calculateTotalSpent() {
        let totalCredit = expenseList.transaction.filter { $0.type == TransactionType.credit.rawValue }.reduce(0) { $0 + $1.amount }
        let totalDebit = expenseList.transaction.filter { $0.type == TransactionType.debit.rawValue }.reduce(0) { $0 + $1.amount }
        totalSpentMonthly = totalCredit - totalDebit
    }

    // Calculate total spending based on categories (excluding income)
    private func calculateTotalSpentByCategory() {
        totalSpentByCategory = expenseList
            .transaction
            .filter { $0.type == TransactionType.debit.rawValue } // Only consider debit transactions
            .filter { $0.category != Category.income.rawValue } // Exclude income category
            .reduce(into: [:]) { result, transaction in
                result[Category(rawValue: transaction.category) ?? .food, default: 0] += transaction.amount
            }
    }

    // Prepare data for bar chart
    private func prepareBarChartData() {
        barChartData = totalSpentByCategory.map { (category, amount) in
            (category: category.rawValue, amount: amount)
        }
    }
}

