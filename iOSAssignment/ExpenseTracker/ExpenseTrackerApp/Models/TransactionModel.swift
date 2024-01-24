//
//  TransactionModel.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import Foundation
import UIKit
struct UserExpenseModel: Codable, Hashable{
    let userName:String
    var transaction:[Transaction]
}

struct Transaction: Codable, Identifiable, Hashable {
    
    let id: String
    var amount: Double
    var type: TransactionType.RawValue
    var category: Category.RawValue
    var signedAmount: Double
    var dateParsed: String
    var month: String
    
    init(amount: Double, type: TransactionType.RawValue, category: Category.RawValue) {
        self.id = UUID().uuidString
        self.amount = amount
        self.type = type
        self.category = category
        self.dateParsed = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Date()))?.description ?? (Date().description)
        self.signedAmount = (type == TransactionType.credit.rawValue) ? amount : -amount
        self.month = Utility.getCurrentMonth()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case type
        case category
        case dateParsed
        case signedAmount
        case month
    }
}

protocol ReloadViewDelegate: AnyObject {
    func viewIdDidChange(newViewId: UUID)
}
//class ReloadView {
//    weak var delegate: ReloadViewDelegate?
//    private var _viewId = UUID() {
//        didSet {
//            delegate?.viewIdDidChange(newViewId: _viewId)
//        }
//    }
//    var viewId: UUID {
//        return _viewId
//    }
//    func updateViewId() {
//        _viewId = UUID()
//    }
//}

enum Category: String,Codable,CaseIterable{
       case income = "Income"
       case food = "Food"
       case travel = "Travel"
       case utilities = "Utilities"
       case entertainment = "Entertainment"
}

enum TransactionType: String,Codable,CaseIterable{
    case credit = "Credit"
    case debit = "Debit"
}
