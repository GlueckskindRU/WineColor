//
//  HapticImpactGeneratorProtocol.swift
//  WineColor
//
//  Created by Yuri Ivashin on 16.07.2025.
//

@MainActor
public protocol HapticImpactGeneratorProtocol {
    func occurs(_ impact: HapticImpact)
}
