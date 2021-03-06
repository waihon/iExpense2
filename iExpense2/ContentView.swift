//
//  ContentView.swift
//  iExpense2
//
//  Created by Waihon Yew on 29/05/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var currencyCode: String {
        let locale = Locale.current
        return locale.currencyCode!
    }

    var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }

    var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }

    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                            }

                            Spacer()
                            Text(item.amount, format: .currency(code: currencyCode))
                                .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .blue : .orange)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }

                Section("Business") {
                    ForEach(businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                            }

                            Spacer()
                            Text(item.amount, format: .currency(code: currencyCode))
                                .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .blue : .orange)
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func removeBusinessItems(at offsets: IndexSet) {
        expenses.removeItems(offsets.map({ businessItems[$0] }))
    }

    func removePersonalItems(at offsets: IndexSet) {
        expenses.removeItems(offsets.map({ personalItems[$0] }))
    }
}

struct CodableUser: Codable {
    var firstName: String
    var lastName: String
}

struct EncodeDecodeContentView: View {
    @State private var user: CodableUser

    init() {
        if let data = UserDefaults.standard.data(forKey: "UserData") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(CodableUser.self, from: data) {
                self.user = decoded
                return
            }
        }
        self.user = CodableUser(firstName: "Taylor", lastName: "Swift")
    }

    var body: some View {
        Text("Hello, \(user.firstName) \(user.lastName)!")
            .padding()

        Button("Save User") {
            user.firstName = "Mariah"
            user.lastName = "Carey"

            let encoder = JSONEncoder()

            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct TapCountContentView: View {
    @AppStorage("Tap") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

struct OnDeleteContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("onDelete()")
            .toolbar {
                EditButton()
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss

    let name: String

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct FirstContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@waihon")
        }
    }
}

class User: ObservableObject {
    // @ObservableObject protocol has no requirements, and really all it
    // means is "we want other things to be able to monitor this for changes."

    // @Published is more or less half of @State: it tells Swift that
    // whenever tagged properties changes, it should send an announcement
    // out to any SwiftUI views that are watching that they shoud reload.
    @Published var firstName = "Bilbo"
    @Published var lastName = "Buggins"
}

struct StateObjectContentView: View {
    // @StateObject is the other half of @State - it tells SwiftUI that we're
    // creating a new class instance that should be watched for any change
    // announcements.
    @StateObject var user = User()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
