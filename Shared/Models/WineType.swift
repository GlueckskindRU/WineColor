//
//  WineType.swift
//  WineColor
//
//  Created by Yuri Ivashin on 01.06.2025.
//

import SwiftUI

enum WineType: String, CaseIterable, Identifiable {
    case white
    case amber
    case rose
    case red

    var id: String { rawValue }

    /// Отображаемое имя — пригодится в UI
    var displayName: String {
        switch self {
        case .white: return "White"
        case .amber: return "Amber"
        case .rose:  return "Rosé"
        case .red:   return "Red"
        }
    }
    
    var buttonColor: Color {
        switch self {
            case .white:
                Color(cgColor: UIColor.whiteWine.cgColor)
            case .amber:
                Color(cgColor: UIColor.amberWine.cgColor)
            case .rose:
                Color(cgColor: UIColor.roseWine.cgColor)
            case .red:
                Color(cgColor: UIColor.redWine.cgColor)
        }
    }
}
