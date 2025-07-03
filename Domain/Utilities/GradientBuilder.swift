//
//  GradientBuilder.swift
//  WineColor
//
//  Created by Yuri Ivashin on 19.06.2025.
//

import SwiftUI

typealias ColorWithBrightness = (color: Color, brightness: CGFloat)

struct GradientBuilder {
    static func sortColorsWithBrightness(from colors: [Color]) -> [ColorWithBrightness] {
        guard colors.isNotEmpty else { return [] }
        
        // Считаем пары (цвет + яркость), исключаем белые
        return colors
            .map { ($0, $0.brightness) }
            .filter { $0.1 < 1.0 }
    }
    
    static func makePerceptualGradient(from colors: [Color]) -> Gradient {
        guard colors.isNotEmpty else { return Gradient(colors: [.clear]) }

        let colorBrightnessPairs = sortColorsWithBrightness(from: colors)
        
        guard !colorBrightnessPairs.isEmpty else {
            return Gradient(colors: colors)
        }

        let brightnesses = colorBrightnessPairs.map(\.1)
        guard
            let min = brightnesses.min(),
            let max = brightnesses.max(),
            min != max
        else {
            return Gradient(colors: colorBrightnessPairs.map(\.0))
        }

        let stops = colorBrightnessPairs.map { color, brightness in
            let normalized = 1.0 - (brightness - min) / (max - min)
            return Gradient.Stop(color: color, location: normalized)
        }

        let sortedStops = stops.sorted { $0.location < $1.location }

        return Gradient(stops: sortedStops)
    }
}

