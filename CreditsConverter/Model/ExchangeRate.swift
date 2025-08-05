//
//  ExchangeRate.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 05.08.2025.
//

import Foundation

struct ExchangeRate: Decodable {
    let rates: Rate
}

struct Rate: Decodable {
    let EUR: Double
}
