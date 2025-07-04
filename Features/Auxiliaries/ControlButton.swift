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
            case .brightness: L10n.Main.Button.brightness
            case .text: L10n.Main.Button.text
            case .eyedropper: L10n.Main.Button.eyedropper
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
