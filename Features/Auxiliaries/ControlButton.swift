//
//  ControlButton.swift
//  WineColor
//
//  Created by Yuri Ivashin on 03.07.2025.
//

import Foundation

enum ControlButton: CaseIterable {
    case brightness
    case text
    case eyedropper

    var title: String {
        switch self {
            case .brightness: return "Brightness"
            case .text: return "Text"
            case .eyedropper: return "Eyedropper"
        }
    }

    var icon: String {
        switch self {
            case .brightness: ActiveMode.none.icon
            case .text: ActiveMode.text.icon
            case .eyedropper: ActiveMode.eyedropper.icon
        }
    }
    
    var iconSelected: String {
        switch self {
            case .brightness: ActiveMode.none.iconSelected
            case .text: ActiveMode.text.iconSelected
            case .eyedropper: ActiveMode.eyedropper.iconSelected
        }
    }
}
