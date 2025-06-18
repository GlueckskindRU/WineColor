//
//  WinePalettes.swift
//  WineColor
//
//  Created by Yuri Ivashin on 01.06.2025.
//

import SwiftUI

enum WinePalettes {
    static let all: [WineType: WinePalette] = [
        .white: WinePalette(
            wineType: .white,
            colors: [
                Color(red: 1.0, green: 1.0, blue: 0.8),
                Color(red: 0.95, green: 0.85, blue: 0.4),
            ]
        ),
        .amber: WinePalette(
            wineType: .amber,
            colors: [
                Color(red: 0.9, green: 0.6, blue: 0.2),
                Color(red: 0.6, green: 0.3, blue: 0.1),
            ]
        ),
        .rose: WinePalette(
            wineType: .rose,
            colors: [
                Color(red: 1.0, green: 0.8, blue: 0.9),
                Color(red: 1.0, green: 0.6, blue: 0.7),
            ]
        ),
        .red: WinePalette(
            wineType: .red,
            colors: [
                Color(red: 0.5, green: 0, blue: 0.1),
                Color(red: 0.3, green: 0, blue: 0),
            ]
        )
    ]

    static func palette(for type: WineType) -> WinePalette {
        all[type] ?? WinePalette(wineType: type, colors: [.white])
    }
}
