//
//  BrightnessViewModel.swift
//  WineColor
//
//  Created by Yuri Ivashin on 08.07.2025.
//

import SwiftUI

// MARK: - Dependencies

extension BrightnessViewModel {
    struct Dependencies {
        let lifecycleObserver: AppLifecycleObserverProtocol
        var screen: BrightnessControlling
    }
}

// MARK: - BrightnessViewModel

@MainActor
final class BrightnessViewModel: ObservableObject {
    @Published var value: CGFloat = 0.5 {
        didSet {
            deps.screen.brightness = value
        }
    }
    
    // MARK: - Private

    private var deps: Dependencies
    private var savedSystemBrightness: CGFloat
    
    // MARK: - Init

    init(
        deps: Dependencies
    ) {
        self.deps = deps
        self.value = deps.screen.brightness
        self.savedSystemBrightness = deps.screen.brightness

        deps.lifecycleObserver.observe(
            onForeground: { [weak self] in
                guard let self else { return }
                self.savedSystemBrightness = self.deps.screen.brightness
                self.deps.screen.brightness = self.value
            },
            onBackground: { [weak self] in
                guard let self else { return }
                self.deps.screen.brightness = self.savedSystemBrightness
            }
        )
    }
    
    deinit {
        Task { @MainActor [weak self] in
            guard let self else { return }
            self.deps.screen.brightness = savedSystemBrightness
        }
    }
}
