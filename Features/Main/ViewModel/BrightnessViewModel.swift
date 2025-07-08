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
            UIScreen.main.brightness = value
        }
    }
    
    // MARK: - Private

    private let lifecycleObserver: AppLifecycleObserver
    private var savedSystemBrightness: CGFloat = UIScreen.main.brightness
    
    // MARK: - Init

    init(observer: AppLifecycleObserver = AppLifecycleObserver()) {
        self.lifecycleObserver = observer
        self.value = UIScreen.main.brightness

        lifecycleObserver.observe(
            onForeground: { [weak self] in
                guard let self else { return }
                self.savedSystemBrightness = UIScreen.main.brightness
                UIScreen.main.brightness = self.value
            },
            onBackground: { [weak self] in
                guard let self else { return }
                UIScreen.main.brightness = self.savedSystemBrightness
            }
        )
    }
    
    deinit {
        Task { @MainActor [weak self] in
            guard let self else { return }
            UIScreen.main.brightness = savedSystemBrightness
        }
    }
}
