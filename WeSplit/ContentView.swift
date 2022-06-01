//
//  ContentView.swift
//  WeSplit
//
//  Created by Alisher Baigazin on 01.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State var checkAmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPersentage: Int = 15
    @FocusState var isKeyboardOnFocus: Bool
    
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode) //init like Int()
        //.currency is: static func currency<Value>(code: String) -> FloatingPointFormatStyle<Value>.Currency where Value : BinaryFloatingPoint
    }
    
    var totalPerPerson: Double {
        return (checkAmount + (checkAmount * Double(tipPersentage) / 100)) / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($isKeyboardOnFocus)
                    Picker("Number of People", selection: $numberOfPeople) {
//                        Text("\(2)").tag(2) tag for identifying
                        ForEach(2..<100, id: \.self) {Text("\($0)")} //range is identifyible
                    }
                } header: {
                    Text("Check")
                }
                
                Section {
                    Picker("Tips", selection: $tipPersentage) {
                        ForEach(1...100, id: \.self) {Text("\($0)")}
                    }
                } header: {
                    Text("Tips")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount:")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isKeyboardOnFocus = false
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
