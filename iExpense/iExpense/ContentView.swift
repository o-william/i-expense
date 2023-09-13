//
//  ContentView.swift
//  iExpense
//
//  Created by Oluwapelumi Williams on 11/09/2023.
//


// Challenges to add to thhis branch of the project
// Use the user's preferred currency
// modify te expense amounts in ContentView to contain some styling depending on their value - expenses under $10 should have one style, expenses under $100 another, and expenses over $1000 a third style.
// Try to split the expenses list into two sections: one for personal expenses and one for business expenses


import SwiftUI


struct ExpenseItem: Identifiable, Codable {
    var id = UUID() // generate a UUID automatically upon creation for uniquely identifying the object.
    let name: String
    let type: String
    let amount: Double
    let currency: String
}

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
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}



struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            //VStack {
                List {
                    // basically copying and pasting here.
                    Section(header: Text("Personal Expenses")){
                        ForEach(expenses.items) { item in
                            if item.type == "Personal" {
                                HStack {
                                    Text(item.name)
                                        .font(.headline)
                                    Spacer()
                                    Text(item.amount, format: .currency(code: item.currency))
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                    .listRowBackground(Color(red: 0.8789, green: 0.8516, blue: 0.7383, opacity: 0.45))
                    .foregroundColor(Color(red: 0.6133, green: 0.4648, blue: 0.3477, opacity: 1.0))
                    
                    Section(header: Text("Business Expenses")){
                        ForEach(expenses.items) { item in
                            if item.type == "Business" {
                                HStack {
                                    Text(item.name)
                                        .font(.headline)
                                    Spacer()
                                    Text(item.amount, format: .currency(code: item.currency))
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                    .listRowBackground(Color(red: 0.8789, green: 0.8516, blue: 0.7383, opacity: 0.45))
                    .foregroundColor(Color(red: 0.6133, green: 0.4648, blue: 0.3477, opacity: 1.0))
//                    .onDelete(perform: removeItems)
                }
                .padding()
                .listStyle(PlainListStyle())
                .background(Color(red: 0.9492, green: 0.9102, blue: 0.8828, opacity: 1.0))
                
                //.padding(.horizontal)
                .navigationTitle("iExpense")
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
                .toolbar {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            //}
            // Navigation View Closing brace directly below
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
