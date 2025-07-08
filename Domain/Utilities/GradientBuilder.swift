//
//  GradientBuilder.swift
//  WineColor
//
//  Created by Yuri Ivashin on 19.06.2025.
//

import SwiftUI

struct ColorWithBrightness: Equatable {
    let color: Color
    let brightness: CGFloat
}

struct GradientBuilder {
    static func perceptualGradient(from input: [ColorWithBrightness]) -> Gradient {
        guard input.isNotEmpty else {
            return Gradient(colors: [])
        }

        let sorted = input.sorted { $0.brightness < $1.brightness }

        guard
            let minBrightness = sorted.first?.brightness,
            let maxBrightness = sorted.last?.brightness
        else {
            return Gradient(colors: sorted.map(\.color))
        }

        if minBrightness == maxBrightness {
            return Gradient(colors: sorted.map(\.color))
        }

        let stops = sorted.map {
            Gradient.Stop(
                color: $0.color,
                location: ($0.brightness - minBrightness) / (maxBrightness - minBrightness)
            )
        }

        return Gradient(stops: stops)
    }
}

