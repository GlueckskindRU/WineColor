//
//  MainScreenViewModel.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import SwiftUI
import Combine

@MainActor
final class MainScreenViewModel: ObservableObject {
    // MARK: - Input State

    @Published var mode: ActiveMode = .brightness {
        didSet {
            logModeChange()
        }
    }

    // MARK: - Properties
    
    let backgroundColor = Color.white
    let appState: AppState

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization

    init(appState: AppState) {
        self.appState = appState

        appState.deps.text.$fontSize
            .receive(on: RunLoop.main)
            .sink { [weak self] newSize in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Mode Checks

    var isBrightnessMode: Bool { mode.isBrightness }
    var isTextMode: Bool { mode.isText }
    var isEyedropperMode: Bool { mode.isEyedropperMode }

    // MARK: - Text

    var fontSize: CGFloat {
        let base: CGFloat = 14
        let max: CGFloat = 40
        return base + (max - base) * appState.deps.text.fontSize
    }
    
    var font: Font {
        return .system(size: fontSize)
    }

    let aboutAppText = L10n.AboutApp.text

    // MARK: - Slider Binding

    var sliderValue: Binding<CGFloat> {
        Binding {
            switch self.mode {
                case .brightness:
                    return self.appState.deps.brightness.value
                case .text:
                    return self.appState.deps.text.fontSize
                case .eyedropper:
                    return .zero
            }
        } set: { newValue in
            switch self.mode {
                case .brightness:
                    self.appState.deps.brightness.value = newValue
                case .text:
                    self.appState.deps.text.fontSize = newValue
                case .eyedropper:
                    break
            }
        }
    }
    
    // MARK: - Analytics
    
    private func logModeChange() {
        let event: AnalyticsEvent

        switch mode {
            case .brightness:
                event = AnalyticsEvent(name: "mode_brightness")
            case .text:
                event = AnalyticsEvent(name: "mode_text")
            case .eyedropper:
                event = AnalyticsEvent(name: "mode_eyedropper")
        }

        Analytics.log(event)
    }
}
