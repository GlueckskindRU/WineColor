//
//  BrightnessControlling.swift
//  WineColor
//
//  Created by Yuri Ivashin on 11.07.2025.
//

import Foundation

@MainActor
public protocol BrightnessControlling {
    var brightness: CGFloat { get set }
}
