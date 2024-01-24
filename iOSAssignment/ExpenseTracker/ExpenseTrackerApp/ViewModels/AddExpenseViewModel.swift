//
//  AddExpenseViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

// AddExpenseView.swift

// AddExpenseViewModel.swift

import Foundation

class AddExpenseViewModel {
    var cacheManager: CacheManager

    init(cacheManager: CacheManager) {
        self.cacheManager = cacheManager
    }

    // Method to add expense to the user's transactions
    func addExpense(amount: Double, type: TransactionType, category: Category) {
        // Retrieve userExpenseModel from cache
        if var userExpenseModel = cacheManager.getCachedModel() {
            let newTransaction = Transaction(amount: amount, type: type.rawValue, category: category.rawValue)
            userExpenseModel.transaction.append(newTransaction)

            // Save the updated list to cache
            cacheManager.saveModel(userExpenseModel)
        } else {
            // Handle case where userExpenseModel is not found
        }
    }
}




