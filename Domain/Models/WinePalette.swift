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
        let sortedColors = GradientBuilder.sortColorsWithBrightness(from: colors).map { $0.color }
        guard sortedColors.isNotEmpty else { return .clear }
        let clamped = min(max(position, 0), 1)

        let segmentedSize = 1.0 / CGFloat(sortedColors.count - 1)
        let index = Int(clamped / segmentedSize)

        if index >= sortedColors.count - 1 {
            return sortedColors[sortedColors.count - 1]
        }

        let fromColor = sortedColors[index]
        let toColor = sortedColors[index + 1]

        let localProgress = (clamped - segmentedSize * CGFloat(index)) / segmentedSize
        return Color.interpolatedColor(from: fromColor, to: toColor, progress: localProgress)
    }

    var gradient: LinearGradient {
        let perceptualGradient = GradientBuilder.makePerceptualGradient(from: colors)
        return LinearGradient(gradient: perceptualGradient, startPoint: .leading, endPoint: .trailing)
    }
}
