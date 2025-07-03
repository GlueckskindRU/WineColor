//
//  AnalyticsEvent.swift
//  WineColor
//
//  Created by Yuri Ivashin on 02.07.2025.
//

import Foundation

/// Модель аналитического события.
struct AnalyticsEvent {
    let name: String
    let parameters: [String: Any]?

    init(name: String, parameters: [String: Any]? = nil) {
        self.name = name
        self.parameters = parameters
    }
}
