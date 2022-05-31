//
//  ContentView.swift
//  iExpense2
//
//  Created by Waihon Yew on 29/05/2022.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}

struct ContentView: View {
    var body: some View {
        Button("Show Sheet") {
            // Show the sheet
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
