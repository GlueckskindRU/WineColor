//
//  ActiveMode+Extension.swift
//  WineColor
//
//  Created by Yuri Ivashin on 03.07.2025.
//

import Foundation

extension ActiveMode {
    var hint: String {
        switch self {
            case .brightness: L10n.Slider.Brightness.hint
            case .text: L10n.Slider.Text.hint
            case .eyedropper: .empty
        }
    }
    
    var title: String {
        switch self {
            case .brightness: L10n.Main.Button.brightness
            case .text: L10n.Main.Button.text
            case .eyedropper: L10n.Main.Button.eyedropper
        }
    }

    var icon: String {
        switch self {
            case .brightness: "lightbulb.max"
            case .text: "text.page"
            case .eyedropper: "camera"
        }
    }
    
    var iconSelected: String {
        switch self {
            case .brightness: "lightbulb.max.fill"
            case .text: "text.page.fill"
            case .eyedropper: "camera.fill"
        }
    }
}
