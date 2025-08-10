//
//  ContentView.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 24.07.2025.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ExchangeRateViewModel()
    
    let buttons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["C", "0", "←"]
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.currencies.indices, id: \.self) { index in
                Text(viewModel.values[index])
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(index == viewModel.selectedCurrencyIndex ? Color.orange : Color.blue, lineWidth: 2)
                    )
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.selectedCurrencyIndex = index
                    })
            }
            
            ForEach(buttons, id: \.self) { buttonsRow in
                HStack {
                    ForEach(buttonsRow, id: \.self) { buttonText in
                        Button {
                            viewModel.buttonPressed(buttonText)
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
        .onAppear() {
            viewModel.loadRate()
        }
    }
}

#Preview {
    ContentView()
}
