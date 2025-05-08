//
//  ContentView.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 07.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isFirstSelected = true
    @State private var isSecondSelected = false

    var body: some View {
        Text("PressMe")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isFirstSelected ? Color.orange : Color.blue, lineWidth: 2)
                    )
                    .onTapGesture {
                        isFirstSelected.toggle()
                        isSecondSelected.toggle()
                    }
        Text("PressMe")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSecondSelected ? Color.orange : Color.blue, lineWidth: 2)
                    )
                    .onTapGesture {
                        isSecondSelected.toggle()
                        isFirstSelected.toggle()
                    }
    }
}

#Preview {
    ContentView()
}
