//
//  AppDependencies.swift
//  WineColor
//
//  Created by Yuri Ivashin on 11.07.2025.
//

import Foundation
import UIKit

// MARK: - AppDependencies

public struct AppDependencies {
    let appLifecycleObserver: AppLifecycleObserverProtocol
    let screen: BrightnessControlling
    let notifications: NotificationPublishing
    let torchController: TorchControllingProtocol
    let hapticImpactGenerator: HapticImpactGeneratorProtocol
    
    public init(
        appLifecycleObserver: AppLifecycleObserverProtocol,
        screen: BrightnessControlling,
        notifications: NotificationPublishing,
        torchController: TorchControllingProtocol,
        hapticImpactGenerator: HapticImpactGeneratorProtocol
    ) {
        self.appLifecycleObserver = appLifecycleObserver
        self.screen = screen
        self.notifications = notifications
        self.torchController = torchController
        self.hapticImpactGenerator = hapticImpactGenerator
    }
}

// MARK: - Default dependencies

extension AppDependencies {
    @MainActor
    static let live = AppDependencies(
        appLifecycleObserver: AppLifecycleObserver(
            notificationCenter: NotificationCenter.default
        ),
        screen: UIScreen.main,
        notifications: NotificationCenter.default,
        torchController: DefaultTorchController(),
        hapticImpactGenerator: HapticImpactGenerator()
    )
}
