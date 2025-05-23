//
//  ContentView.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 07.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var currencies: [(name: String, value: String, isSelected: Bool)] = [
        ("Credit", "0", true),
        ("Dollar", "0", false),
        ("Euro", "0", false)
    ]
    
    private let buttonsValues = [
        ["AC", "←", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", "+/-", ".", "="]
    ]
    
    private var selectedCurrencyIndex: Int {
        for (i, currency) in currencies.enumerated() {
            if currency.isSelected {return i}
        }
        return 0
    }
    
    private var selectedNumber: Double? {
        var text = currencies[selectedCurrencyIndex].value
        if stringHasOperator(text) {
            text.removeLast()
        }
        return Double(text)
    }
    
    private func stringHasOperator(_ str: String) -> Bool {
        return "+-÷×".contains(str.last!)
    }
    
    private func formatNumber(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", number)
        } else {
            return String(number)
        }
    }
    
    @State var calcLogic = Array(repeating: CalculatorLogic(), count: 3)
    
    private func buttonPressed(_ buttonText: String)  {
        if buttonText == "." && currencies[selectedCurrencyIndex].value.contains(".") {
            return
        }
        switch buttonText {
        case "←":
            if currencies[selectedCurrencyIndex].value == "0" {
                break
            } else if currencies[selectedCurrencyIndex].value.count == 1 {
                currencies[selectedCurrencyIndex].value = "0"
            } else {
                currencies[selectedCurrencyIndex].value.removeLast()
            }
        case "%", "+/-", "AC":
            if let safeNumber = selectedNumber {
                currencies[selectedCurrencyIndex].value = formatNumber(calcLogic[selectedCurrencyIndex].calculate(newNumber: safeNumber, operatorText: buttonText)!)
            }
        case "+", "-", "÷", "×", "=":
            if stringHasOperator(currencies[selectedCurrencyIndex].value) {
                calcLogic[selectedCurrencyIndex].setOperator(buttonText)
                
            } else if let safeNumber = selectedNumber {
                    currencies[selectedCurrencyIndex].value = formatNumber(calcLogic[selectedCurrencyIndex].calculate(newNumber: safeNumber, operatorText: buttonText)!)
                }
            
                currencies[selectedCurrencyIndex].value += buttonText != "=" ? buttonText : ""
            
        default:
            if currencies[selectedCurrencyIndex].value == "0" {
                currencies[selectedCurrencyIndex].value = buttonText
            } else {
                if stringHasOperator(currencies[selectedCurrencyIndex].value) {
                    currencies[selectedCurrencyIndex].value = ""
                }
                currencies[selectedCurrencyIndex].value += buttonText
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                ForEach(currencies, id: \.name) { currency in
                    Button(action: {
                        for i in 0..<currencies.count {
                            if currencies[i].name == currency.name {
                                currencies[i].isSelected.toggle()
                            } else {
                                currencies[i].isSelected = false
                            }
                        }
                    }) {
                        Text(currency.value)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(currency.isSelected ? Color.orange : Color.blue, lineWidth: 2)
                            )
                    }
                }
                
                Spacer()
                
                ForEach(buttonsValues, id: \.first) { row in
                    HStack(spacing: 20) {
                        ForEach(row, id: \.self) { buttonText in
                            Button(action: {buttonPressed(buttonText)}) {
                                Text(buttonText)
                                    .padding()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .background(
                                        Circle()
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
