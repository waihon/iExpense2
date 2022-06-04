//
//  ExpenseItem.swift
//  iExpense2
//
//  Created by Waihon Yew on 04/06/2022.
//

import Foundation

struct ExpenseItem {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
