//
//  ContentView.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 07.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var currencies: [(name: String, value: String, isSelected: Bool)] = [
        ("Credit", "", true),
        ("Dollar", "", false),
        ("Euro", "", false)
    ]

    private let buttonsValues = [
        ["AC", "←", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", "+/-", ".", "="]
    ]
    
    var body: some View {
        
        ForEach(currencies, id: \.name) { currency in
            Text(currency.name)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(currency.isSelected ? Color.orange : Color.blue, lineWidth: 2)
                )
                .onTapGesture {
                    for i in 0..<currencies.count {
                        if currencies[i].name == currency.name {
                            currencies[i].isSelected.toggle()
                        } else {
                            currencies[i].isSelected = false
                        }
                    }
                }
        }
        ForEach(buttonsValues, id: \.first) { row in
            HStack {
                ForEach(row, id: \.self) { buttonText in
                    Button {
                        print(buttonText)
                    } label: {
                        Text(buttonText)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
