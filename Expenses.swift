//
//  Expenses.swift
//  iExpense2
//
//  Created by Waihon Yew on 04/06/2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [Expenses]()
}