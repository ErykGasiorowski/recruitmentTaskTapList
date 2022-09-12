//
//  CellInput.swift
//  ListTap
//
//  Created by Eryk Gasiorowski on 12/09/2022.
//

import Foundation
import UIKit

enum Color: CaseIterable {
    case red, blue
}

struct CellInput {
    private let color: Color = .allCases.randomElement()!
    let isSeparatorHidden: Bool
    var number: Int = .random(in: 0...9)
    
    var displayValue: Int {
        switch color {
        case .red: return number * 3
        case .blue: return number
        }
    }
    
    var displayColor: UIColor {
        switch color {
        case .red:
            return .systemRed
        case .blue:
            return .systemBlue
        }
    }
}
