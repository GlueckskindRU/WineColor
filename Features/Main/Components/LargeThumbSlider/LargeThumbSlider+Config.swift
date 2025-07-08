//
//  LargeThumbSlider+Config.swift
//  WineColor
//
//  Created by Yuri Ivashin on 08.07.2025.
//

import SwiftUI

extension LargeThumbSlider {
    struct Config {
        let range: ClosedRange<CGFloat>
        let thumbSize: CGFloat
        let trackHeight: CGFloat
    }
}

extension LargeThumbSlider.Config {
    static let `default` = Self(range: 0...1, thumbSize: 32, trackHeight: 6)
    static let compact = Self(range: 0...1, thumbSize: 24, trackHeight: 4)
    static let large = Self(range: 0...1, thumbSize: 50, trackHeight: 6)
}
