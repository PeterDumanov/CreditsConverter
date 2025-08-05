//
//  ExchangeRateViewModel.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 05.08.2025.
//

import Foundation

class ExchangeRateViewModel: ObservableObject {
    @Published var rates: [String : Double]?
    
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
            print(rates)
        } catch {
            print("Ошибка: \(error)")
        }
    }
}
