//
//  ContentView.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 24.07.2025.
//

import SwiftUI

struct ContentView: View {
    var currencies = ["EUR", "USD", "CRD"]
    @State var values = Array(repeating: "0", count: 3)
    @State var selectedCurrencyIndex = 0
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(currencies.indices, id: \.self) { index in
                Text(values[index])
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .simultaneousGesture(TapGesture().onEnded {
                        selectedCurrencyIndex = index
                        print(selectedCurrencyIndex)
                    })
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
