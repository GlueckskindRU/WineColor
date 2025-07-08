//
//  ActiveMode.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import Foundation

enum ActiveMode: Equatable, CaseIterable {
    case brightness
    case text
    case eyedropper

    var isBrightness: Bool {
        self == .brightness
    }

    var isText: Bool {
        self == .text
    }

    var isEyedropperMode: Bool {
        self == .eyedropper
    }
    
    var isSliderEnabled: Bool {
        self != .eyedropper
    }
}
