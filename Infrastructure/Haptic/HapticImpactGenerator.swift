//
//  HapticImpactGenerator.swift
//  WineColor
//
//  Created by Yuri Ivashin on 16.07.2025.
//

import UIKit

@MainActor
public struct HapticImpactGenerator: HapticImpactGeneratorProtocol {
    public func occurs(_ impact: HapticImpact) {
        switch impact {
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.prepare()
                generator.impactOccurred()
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()
            case .success:
                let generator = UINotificationFeedbackGenerator()
                generator.prepare()
                generator.notificationOccurred(.success)
            case .warning:
                let generator = UINotificationFeedbackGenerator()
                generator.prepare()
                generator.notificationOccurred(.warning)
            case .error:
                let generator = UINotificationFeedbackGenerator()
                generator.prepare()
                generator.notificationOccurred(.error)
        }
    }
}
