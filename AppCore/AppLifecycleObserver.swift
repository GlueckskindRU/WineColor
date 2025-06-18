//
//  AppLifecycleObserver.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import UIKit
import Combine

@MainActor
final class AppLifecycleObserver {
    private var cancellables = Set<AnyCancellable>()
    private let screen: UIScreen
    private let notificationCenter: NotificationCenter

    private var onBackground: (() -> Void)?
    private var onForeground: (() -> Void)?

    init(
        screen: UIScreen = .main,
        notificationCenter: NotificationCenter = .default
    ) {
        self.screen = screen
        self.notificationCenter = notificationCenter
    }

    func observe(
        onForeground: @escaping () -> Void,
        onBackground: @escaping () -> Void
    ) {
        self.onForeground = onForeground
        self.onBackground = onBackground

        notificationCenter.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in self?.onForeground?() }
            .store(in: &cancellables)

        notificationCenter.publisher(for: UIApplication.willResignActiveNotification)
            .sink { [weak self] _ in self?.onBackground?() }
            .store(in: &cancellables)
    }
}
