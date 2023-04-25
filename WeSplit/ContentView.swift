//
//  ContentView.swift
//  WeSplit
//
//  Created by Ivan Yarmoliuk on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipProcentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let currrencyCode = Locale.current.currency?.identifier ?? "USD"
    
    let tipProcentages = [10, 25, 20, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipProcentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipProcentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currrencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<51) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker ("Tip procentage", selection: $tipProcentage) {
                        ForEach (0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much tip you want to leave?")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: currrencyCode))
                } header: {
                    Text("Total amount with tips:")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currrencyCode))
                } header: {
                    Text("Amount per person:")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
