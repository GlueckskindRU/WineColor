//
//  ActiveMode+Extension.swift
//  WineColor
//
//  Created by Yuri Ivashin on 03.07.2025.
//

import Foundation

extension ActiveMode {
    var title: String {
        switch self {
            case .none: L10n.Slider.Brightness.hint
            case .text: L10n.Slider.Text.hint
            case .eyedropper: .empty
        }
    }

    var icon: String {
        switch self {
            case .none: "lightbulb.max"
            case .text: "text.page"
            case .eyedropper: "camera"
        }
    }
    
    var iconSelected: String {
        switch self {
            case .none: "lightbulb.max.fill"
            case .text: "text.page.fill"
            case .eyedropper: "camera.fill"
        }
    }
}
