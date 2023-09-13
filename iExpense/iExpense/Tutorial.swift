////
////  Tutorial.swift
////  iExpense
////
////  Created by Oluwapelumi Williams on 13/09/2023.
////
//
////
////  ContentView.swift
////  iExpense
////
////  Created by Oluwapelumi Williams on 11/09/2023.
////
//
//import SwiftUI
//
//
//class User: ObservableObject {
//    @Published var firstName = "Bilbo"
//    @Published var lastName = "Baggins"
//}
//
//struct User2: Codable {
//    let firstName: String
//    let lastName: String
//}
//
//// FOR SHOWING A SECOND VIEW
//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//    
//    let name: String
//    
//    var body: some View {
//        
//        Text("Second View")
//        Text("Hello, \(name)!")
//        
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}
//
//struct ContentView: View {
//    
//    @StateObject var user = User()
//    @State private var showingSheet = false
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//    
//    // Setting user defaults
//    // @State private var tapCount = 0
//    
//    // @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//    // Alternative way of writing this is below:
//    @AppStorage("tapCount") private var tapCount = 0
//    
//    // For storing user data using Codable
//    @State private var user2 = User2(firstName: "Taylor", lastName: "Swift")
//    
//    
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName).")
//            
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//            
//            NavigationView {
//                VStack {
//                    List {
//                        ForEach(numbers, id: \.self) {
//                            Text("Row \($0)")
//                        }
//                        .onDelete(perform: removeRows)
//                    }
//                    Button("Add Number") {
//                        numbers.append(currentNumber)
//                        currentNumber += 1
//                    }
//                }
//                .toolbar {
//                    EditButton()
//                }
//            }
//            
//            Button("Tap count: \(tapCount)") {
//                tapCount += 1
//                // If we use @AppStorage, we don't need to use the below to store the data
//                // UserDefaults.standard.set(self.tapCount, forKey: "Tap")
//            }
//            
//            Button("Save User") {
//                let encoder = JSONEncoder()
//                
//                if let data = try? encoder.encode(user2) {
//                    UserDefaults.standard.set(data, forKey: "UserData")
//                }
//            }
//            
//            Button("Show Sheet") {
//                showingSheet.toggle()
//            }
//            .sheet(isPresented: $showingSheet) {
//                SecondView(name: "@mr_whillz")
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
