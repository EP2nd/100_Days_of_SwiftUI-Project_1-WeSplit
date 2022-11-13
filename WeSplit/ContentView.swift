//
//  ContentView.swift
//  WeSplit
//
//  Created by Edwin Przeźwiecki Jr. on 11/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool

    /// Challenge 3:
    //let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    /// Challenge 2:
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let totalAmount = checkAmount + tipValue
        
        return totalAmount
    }
    
    /// Bonus challenge:
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
        
        return localCurrency
    }
    
    /* static func currency<Value>(code: String) -> FloatingPointFormatStyle<Value>.Currency where Value : BinaryFloatingPoint */

    var body: some View {
        NavigationView {
            Form {
                Section {
                    /// Bonus challenge:
                    TextField("Amount", value: $checkAmount, format: currencyFormatter)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    //.pickerStyle(.navigationLink)
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        /// Challenge 3:
                        /* ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        } */
                        ForEach(0 ..< 101) {
                            Text("\($0)%")
                        }
                    }
                    /// Challenge 3:
                    //.pickerStyle(.segmented)
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    /// Bonus challenge:
                    Text(totalPerPerson, format: currencyFormatter)
                /// Challenge 1:
                } header: {
                    Text("Amount per person:")
                }
                /// Challenge 2:
                Section {
                    /// Bonus challenge:
                    Text(totalAmount, format: currencyFormatter)
                } header: {
                    Text("Total amount:")
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
