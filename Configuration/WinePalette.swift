//
//  WinePalette.swift
//  WineColor
//
//  Created by Yuri Ivashin on 01.06.2025.
//

import SwiftUI

struct WinePalette {
    let wineType: WineType
    let colors: [Color]

    /// Возвращает цвет из палитры, соответствующий положению слайдера (от 0.0 до 1.0)
    func color(at position: CGFloat) -> Color {
        guard colors.isNotEmpty else { return .clear }
        let clamped = min(max(position, 0), 1)

        let segmentedSize = 1.0 / CGFloat(colors.count - 1)
        let index = Int(clamped / segmentedSize)

        if index >= colors.count - 1 {
            return colors[colors.count - 1]
        }

        let fromColor = colors[index]
        let toColor = colors[index + 1]

        let localProgress = (clamped - segmentedSize * CGFloat(index)) / segmentedSize
        return Color.interpolatedColor(from: fromColor, to: toColor, progress: localProgress)
    }

    var gradient: LinearGradient {
        LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
    }
}
