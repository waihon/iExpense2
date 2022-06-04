//
//  AddView.swift
//  iExpense2
//
//  Created by Waihon Yew on 04/06/2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    // We don't need to specify a type for dismiss as Swift can figure it
    // out thanks tot the @Environment property wrapper.
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @FocusState private var isFocused: Bool
    @State private var firstAppear = true

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .focused($isFocused)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            .onAppear() {
                if firstAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        isFocused = true
                    }
                    firstAppear.toggle()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
