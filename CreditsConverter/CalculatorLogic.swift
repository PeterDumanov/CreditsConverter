//
//  CalculatorLogic.swift
//  CreditsConverter
//
//  Created by Petr Dumanov on 11.05.2025.
//

import Foundation

struct CalculatorLogic {
    
    var currentNumber: Double?
    
    private var currentOperator: ((Double, Double) -> Double)?
    
    private let operatorsDict: [String: (Double, Double) -> Double] = [
        "÷": (/),
        "×": (*),
        "-": (-),
        "+": (+),
    ]
    
    mutating func setOperator(_ operatorText: String) {
        currentOperator = operatorsDict[operatorText]
    }
    
    mutating func calculate(newNumber: Double, operatorText: String) -> Double? {
        switch operatorText {
        case "AC":
            currentNumber = nil
            currentOperator = nil
            return 0
        case "%":
            return newNumber / 100.00
        case "+/-":
            return -newNumber
        case  "÷", "×", "-", "+":
            if currentNumber == nil {
                currentNumber = newNumber
            } else {
                currentNumber = currentOperator!(currentNumber!, newNumber)
            }
            setOperator(operatorText)
            return currentNumber
        case "=":
            var result = newNumber
            if currentNumber != nil && currentOperator != nil {
                result = currentOperator!(currentNumber!, newNumber)
                currentNumber = nil
                currentOperator = nil
            }
            return result
        default:
            return newNumber
        }
    }
}
