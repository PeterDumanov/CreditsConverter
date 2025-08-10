//
//  ExchangeRateViewModel.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 05.08.2025.
//

import Foundation

class ExchangeRateViewModel: ObservableObject {
    @Published var rates: [String : Double]?
    let currencies = ["EUR", "USD", "CRD"]
    @Published var values = Array(repeating: "0", count: 3)
    @Published var selectedCurrencyIndex = 0
    
    func loadRate() {
            Task {
                await fetchRate()
            }
        }
    
    private func setRates(_ euroDollarRate: Double) {
        rates = [String : Double]()
        rates!["EUR_USD"] = euroDollarRate
        rates!["USD_EUR"] = 1.0 / euroDollarRate
        rates!["EUR_CRD"] = (1.0 + euroDollarRate) / 2.0
        rates!["CRD_EUR"] = 1.0 / rates!["EUR_CRD"]!
        rates!["USD_CRD"] = (1.0 + rates!["USD_EUR"]!) / 2.0
        rates!["CRD_USD"] = 1.0 / rates!["USD_CRD"]!
    }
    
    private func fetchRate() async {
        guard let url = URL(string: "https://api.frankfurter.app/latest?from=USD&to=EUR") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let euroDollar = try JSONDecoder().decode(ExchangeRate.self, from: data)
            setRates(euroDollar.rates.EUR)
            convertValues()
        } catch {
            print("Ошибка: \(error)")
        }
    }
    
    func buttonPressed(_ buttonText: String) {
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
        convertValues()
    }
    
    func convertValues() {
        if let rates = rates {
            let targetCurrency = currencies[selectedCurrencyIndex]
            let selectedNumericalValue = Double(values[selectedCurrencyIndex]) ?? 0.0
            for i in 0..<values.count {
                if i != selectedCurrencyIndex {
                    let newValue = selectedNumericalValue * (rates["\(currencies[i])_\(targetCurrency)", default: 0.0])
                    values[i] = newValue.truncatingRemainder(dividingBy: 1) == 0
                        ? String(format: "%.0f", newValue)
                        : String(format: "%.2f", newValue)
                }
            }
        }
    }
    
}
