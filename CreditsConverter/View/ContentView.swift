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
        ZStack {
            LinearGradient(colors: [.black, .uiPrimary], startPoint: .center, endPoint: .bottom)
                .ignoresSafeArea()

                
            VStack(spacing: 16) {
                Spacer()
                ForEach(viewModel.currencies.indices, id: \.self) { index in
                    let isSelected = index == viewModel.selectedCurrencyIndex
                    let primaryColor: Color = isSelected ? .uiSecondary : .uiPrimary

                    ZStack {
                        Text(viewModel.currencies[index])
                            .foregroundColor(primaryColor)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(viewModel.values[index])
                            .foregroundColor(primaryColor)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(10)
                    .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(primaryColor, lineWidth: 2)
                    )
                    .onTapGesture {
                        viewModel.selectedCurrencyIndex = index
                    }
                }
                
                Spacer()
                
                ForEach(buttons, id: \.self) { buttonsRow in
                    HStack {
                        ForEach(buttonsRow, id: \.self) { buttonText in
                            Spacer()
                            Button {
                                viewModel.buttonPressed(buttonText)
                            } label: {
                                Text(buttonText)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.uiPrimary)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.uiPrimary, lineWidth: 2)
                                    )
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
            .padding()
            .onAppear() {
                viewModel.loadRate()
            }
        }
    }
}

#Preview {
    ContentView()
}
