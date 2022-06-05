//
//  Expenses.swift
//  iExpense2
//
//  Created by Waihon Yew on 04/06/2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            // .self is used to say that we mean we're referring to the
            // type itself, known as the type object.
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }

    func removeItems(_ expenseItems: [ExpenseItem]) {
        // https://developer.apple.com/forums/thread/665140
        items.removeAll(where: { expenseItems.contains($0) })
    }
}
