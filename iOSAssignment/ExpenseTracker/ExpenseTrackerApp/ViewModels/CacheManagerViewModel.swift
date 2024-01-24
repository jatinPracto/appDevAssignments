//
//  ExpenseViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Jatin Kamal Vangani on 22/01/24.
//

import Foundation

final class CacheManager {
    private let cacheKey: String
    
    weak var delegate: ReloadViewDelegate?

    init(cacheKey: String) {
        self.cacheKey = cacheKey
    }

    // MARK: Public Methods
    var isCacheAvailable: Bool {
        return UserDefaults.standard.object(forKey: cacheKey) != nil
    }

    func getCachedModel() -> UserExpenseModel? {
        if let cachedData = UserDefaults.standard.data(forKey: cacheKey),
           let cachedModel = try? JSONDecoder().decode(UserExpenseModel.self, from: cachedData) {
            return cachedModel
        }
        return nil
    }

    func saveModel(_ model: UserExpenseModel) {
        do {
            let data = try JSONEncoder().encode(model)
            UserDefaults.standard.set(data, forKey: cacheKey)
            delegate?.viewIdDidChange(newViewId: UUID()) 
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }

    func clearCache() {
        UserDefaults.standard.removeObject(forKey: cacheKey)
        delegate?.viewIdDidChange(newViewId: UUID())
    }
}




