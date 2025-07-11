//
//  AppLifecycleObserverMock.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 10.07.2025.
//

import Foundation
import WineColor

@MainActor
final class AppLifecycleObserverMock: AppLifecycleObserverProtocol {
    private(set) var onBackgroundHandler: (() -> Void)?
    private var onForegroundHandler: (() -> Void)?

    func observe(
        onForeground: @escaping () -> Void,
        onBackground: @escaping () -> Void
    ) {
        self.onForegroundHandler = onForeground
        self.onBackgroundHandler = onBackground
    }
}
