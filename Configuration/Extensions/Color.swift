//
//  Color.swift
//  WineColor
//
//  Created by Yuri Ivashin on 01.06.2025.
//

import SwiftUI

extension Color {
    static func interpolatedColor(from: Color, to: Color, progress: CGFloat) -> Color {
        let fromComponents = UIColor(from).cgColor.components ?? [0, 0, 0, 1]
        let toComponents = UIColor(to).cgColor.components ?? [0, 0, 0, 1]

        let r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * progress
        let g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * progress
        let b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * progress
        let a = fromComponents[3] + (toComponents[3] - fromComponents[3]) * progress

        return Color(red: r, green: g, blue: b, opacity: a)
    }
    
    /// Вычисляет воспринимаемую яркость цвета (0.0 - тёмный, 1.0 - светлый).
    var brightness: CGFloat {
        let uiColor = UIColor(self)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        let success = uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        guard success else {
            // Если не удалось извлечь компоненты — считаем цвет светлым по умолчанию
            return 1.0
        }

        return red * 0.299 + green * 0.587 + blue * 0.114
    }
}
