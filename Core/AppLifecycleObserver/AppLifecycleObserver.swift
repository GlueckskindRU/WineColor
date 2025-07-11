//
//  AppLifecycleObserver.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import UIKit.UIApplication
import Combine

@MainActor
final class AppLifecycleObserver: AppLifecycleObserverProtocol {
    private var cancellables = Set<AnyCancellable>()
    private let notificationCenter: NotificationPublishing

    private var onBackground: (() -> Void)?
    private var onForeground: (() -> Void)?

    init(
        notificationCenter: NotificationPublishing
    ) {
        self.notificationCenter = notificationCenter
    }

    public func observe(
        onForeground: @escaping () -> Void,
        onBackground: @escaping () -> Void
    ) {
        self.onForeground = onForeground
        self.onBackground = onBackground

        notificationCenter.publisher(for: UIApplication.willEnterForegroundNotification, object: nil)
            .sink { [weak self] _ in self?.onForeground?() }
            .store(in: &cancellables)

        notificationCenter.publisher(for: UIApplication.willResignActiveNotification, object: nil)
            .sink { [weak self] _ in self?.onBackground?() }
            .store(in: &cancellables)
    }
}
