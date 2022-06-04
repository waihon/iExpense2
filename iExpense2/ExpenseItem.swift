//
//  ExpenseItem.swift
//  iExpense2
//
//  Created by Waihon Yew on 04/06/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    // For decoding a property with a default value, we have to declare
    // it as var instead of as let.
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
