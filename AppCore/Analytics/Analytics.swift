//
//  Analytics.swift
//  WineColor
//
//  Created by Yuri Ivashin on 02.07.2025.
//

import Foundation

/// Обёртка для логирования аналитических событий.
/// Сейчас просто печатает в консоль. В будущем сюда можно подключить Firebase, TelemetryDeck и пр.
enum Analytics {
    static func log(_ event: AnalyticsEvent) {
        #if DEBUG
        print("🟡 Analytics Event: \(event.name)\nParameters: \(event.parameters ?? [:])")
        #else
        // Здесь будет вызов стороннего SDK, например:
        // FirebaseAnalytics.logEvent(event.name, parameters: event.parameters)
        #endif
    }
}
