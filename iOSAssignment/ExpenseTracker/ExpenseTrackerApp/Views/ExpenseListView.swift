//
//  ExpenseListView.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

// ...

import UIKit
class ExpenseListView: UIViewController {

    var cacheManager: CacheManager!

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expenses"
        view.backgroundColor = .white

        setupTableView()
        cacheManager.delegate = self
    }

    init(cacheManager: CacheManager) {
        self.cacheManager = cacheManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: ExpenseTableViewCell.identifier)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ExpenseListView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Safely unwrap the optional values
        return cacheManager.getCachedModel()?.transaction.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseTableViewCell.identifier, for: indexPath) as! ExpenseTableViewCell

        // Safely unwrap the optional values
        if let transactions = cacheManager.getCachedModel()?.transaction, indexPath.row < transactions.count {
            let expense = transactions[indexPath.row]
            cell.configure(with: expense)
        }

        return cell
    }
}

// MARK: - ReloadViewDelegate

extension ExpenseListView: ReloadViewDelegate {
    func viewIdDidChange(newViewId: UUID) {
        // Handle view update when CacheManager triggers a change
        tableView.reloadData()
    }
}





