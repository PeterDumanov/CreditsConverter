//
//  ContentView.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 24.07.2025.
//

import SwiftUI

struct ContentView: View {
    var currencies = ["EUR", "USD", "CRD"]
    @State var values = Array(repeating: "1", count: 3)
    @State var selectedCurrencyIndex = 0
    @StateObject private var viewModel = ExchangeRateViewModel()
    
    let buttons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["C", "0", "←"]
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(currencies.indices, id: \.self) { index in
                Text(values[index])
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(index == selectedCurrencyIndex ? Color.orange : Color.blue, lineWidth: 2)
                    )
                    .simultaneousGesture(TapGesture().onEnded {
                        selectedCurrencyIndex = index
                        print(selectedCurrencyIndex)
                    })
            }
            
            ForEach(buttons, id: \.self) { buttonsRow in
                HStack {
                    ForEach(buttonsRow, id: \.self) { buttonText in
                        Button {
                            buttonPressed(buttonText)
                        } label: {
                            Text(buttonText)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Circle()
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.loadRate()
        }
    }
    
    private func buttonPressed(_ buttonText: String) {
        switch buttonText {
        case "C":
            values[selectedCurrencyIndex] = "0"
        case "←":
            if values[selectedCurrencyIndex].count > 1 {
                values[selectedCurrencyIndex].removeLast()
                if values[selectedCurrencyIndex].last == "." {
                    values[selectedCurrencyIndex].removeLast()
                }
            } else {
                values[selectedCurrencyIndex] = "0"
            }
        default:
            if values[selectedCurrencyIndex] == "0" {
                values[selectedCurrencyIndex] = buttonText
            } else {
                values[selectedCurrencyIndex] += buttonText
            }
        }
    }
}

#Preview {
    ContentView()
}
