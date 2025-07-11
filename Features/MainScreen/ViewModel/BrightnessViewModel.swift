//
//  BrightnessViewModel.swift
//  WineColor
//
//  Created by Yuri Ivashin on 08.07.2025.
//

import SwiftUI

@MainActor
final class BrightnessViewModel: ObservableObject {
    @Published var value: CGFloat = 0.5 {
        didSet {
            screen.brightness = value
        }
    }
    
    // MARK: - Private

    private let lifecycleObserver: AppLifecycleObserver
    private var screen: BrightnessControlling
    private var savedSystemBrightness: CGFloat
    
    // MARK: - Init

    init(
        observer: AppLifecycleObserver = AppLifecycleObserver(
            notificationCenter: NotificationCenter.default
        ),
        screen: BrightnessControlling = UIScreen.main
    ) {
        self.lifecycleObserver = observer
        self.screen = screen
        self.value = screen.brightness
        self.savedSystemBrightness = screen.brightness

        lifecycleObserver.observe(
            onForeground: { [weak self] in
                guard let self else { return }
                self.savedSystemBrightness = self.screen.brightness
                self.screen.brightness = self.value
            },
            onBackground: { [weak self] in
                guard let self else { return }
                self.screen.brightness = self.savedSystemBrightness
            }
        )
    }
    
    deinit {
        Task { @MainActor [weak self] in
            guard let self else { return }
            self.screen.brightness = savedSystemBrightness
        }
    }
}
