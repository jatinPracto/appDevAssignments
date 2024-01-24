//
//  DashBoardView.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import Foundation
import UIKit

class DashboardView: UITabBarController {

    private let userName: String

    init(userName: String) {
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureTabBar()
    }

    private func setupTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
    }

    private func configureTabBar() {
        let cacheManager = CacheManager(cacheKey: userName)

        let expenseListView = ExpenseListView(cacheManager: cacheManager)
        expenseListView.cacheManager = cacheManager
        expenseListView.tabBarItem = UITabBarItem(title: "Expenses", image: UIImage(named: "expenses"), tag: 0)

        let addExpenseView = AddExpenseView(cacheManager: cacheManager)
        addExpenseView.tabBarItem = UITabBarItem(title: "Add Expense", image: UIImage(named: "hello"), tag: 1)

        let budgetAnalyticsView = BudgetAnalyticsView(cacheManager: cacheManager)
        budgetAnalyticsView.tabBarItem = UITabBarItem(title: "Budget & Analytics", image: UIImage(named: "budget"), tag: 2)

        viewControllers = [createNavigationController(for: expenseListView),
                           createNavigationController(for: addExpenseView),
                           createNavigationController(for: budgetAnalyticsView)]
    }

    private func createNavigationController(for viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .systemBlue
        return navigationController
    }
}

