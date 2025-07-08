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
            case .white: L10n.Wines.whiteWine
            case .amber: L10n.Wines.amberWine
            case .rose: L10n.Wines.roseWine
            case .red: L10n.Wines.redWine
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
