//
//  AddView.swift
//  iExpense
//
//  Created by Oluwapelumi Williams on 13/09/2023.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss // we don't specify a type for this. Swift can figure it out due to the @Environment property wrapper
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"
    
    // let currencies = ["USD", "EUR"]
        static var locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        let currencies: [String] = Set(locales.compactMap { $0.currency?.identifier }).sorted()
        
    
    // function to return the name of a currency.
    func currencyName(currencyCode: String) -> String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))
        return locale.localizedString(forCurrencyCode: currencyCode) ?? currencyCode
    }
    
    // function to validate if the user entered anything in the name field
    func isNameNotEmpty(expenseName: String) -> Bool {
        let formattedString = expenseName.trimmingCharacters(in: .whitespaces)
        return formattedString != ""
        // change the color to the name field to red
    }
    
    // function to validate if the user entered a positive amount
    func isAmountPositive(expenseAmount: Double) -> Bool {
        return expenseAmount > 0.0
        // change the color of the amount field to red
    }
    
    // run input checks
    func inputChecksPassed(expenseName: String, expenseAmount: Double) -> Bool {
        return isNameNotEmpty(expenseName: expenseName) && isAmountPositive(expenseAmount: expenseAmount)
    }
    
    let types = ["Business", "Personal"]
    
    // MAIN VIEW
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    
                }
                .background(Color(red: 0.9492, green: 0.9102, blue: 0.8828, opacity: 1.0))
                
                Form {
                    TextField("Name", text: $name)
                        .listRowBackground(Color(red: 0.8789, green: 0.8516, blue: 0.7383, opacity: 0.45))
                        .foregroundColor(Color(red: 0.6133, green: 0.4648, blue: 0.3477, opacity: 1.0))
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .listRowBackground(Color(red: 0.8789, green: 0.8516, blue: 0.7383, opacity: 0.45))
                    .foregroundColor(Color(red: 0.6133, green: 0.4648, blue: 0.3477, opacity: 1.0))
                    
                    HStack {
                        TextField("Amount", value: $amount, format: .currency(code: currency))
                            .keyboardType(.decimalPad)
                        
                        Picker("Currrency", selection: $currency) {
                            ForEach(currencies, id: \.self) { currencyCode in
                                Text("\(currencyName(currencyCode: currencyCode)) (\(currencyCode))")
                                // .tag(currencyCode)
                            }
                        }
                        .labelsHidden()
                        .padding()
                    }
                    .listRowBackground(Color(red: 0.8789, green: 0.8516, blue: 0.7383, opacity: 0.45))
                    .foregroundColor(Color(red: 0.6133, green: 0.4648, blue: 0.3477, opacity: 1.0))
                }
                // .padding()
                // .listStyle(GroupedListStyle())
                // .background(Color(red: 0.9492, green: 0.9102, blue: 0.8828, opacity: 1.0))
                
                // .navigationTitle("Add new expense")
            }
                .navigationBarTitle("Add new expense", displayMode: .inline)
                .toolbar {
                    Button("Save") {
                        guard (inputChecksPassed(expenseName: name, expenseAmount: amount)) else {
                            // change the color of the Name field to red
                            // change the color of the amount field to red
                            return
                        }
                        let item = ExpenseItem(name: name.trimmingCharacters(in: .whitespaces), type: type, amount: amount, currency: currency)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            
            // NavigationView closing brace below
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses()) // this is not allowed anymore, but just for the preview
    }
}
