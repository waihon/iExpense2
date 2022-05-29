//
//  ContentView.swift
//  iExpense2
//
//  Created by Waihon Yew on 29/05/2022.
//

import SwiftUI

class User {
    var firstName = "Bilbo"
    var lastName = "Buggins"
}

struct ContentView: View {
    @State private var user = User()

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
