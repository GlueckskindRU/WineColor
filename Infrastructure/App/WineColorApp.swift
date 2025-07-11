//
//  WineColorApp.swift
//  WineColor
//
//  Created by Yuri Ivashin on 31.05.2025.
//

import SwiftUI

@main
struct WineColorApp: App {
    @StateObject private var appState = AppState(
        context: AppState.Context(initialActiveMode: .brightness),
        deps: AppState.Dependencies(
            brightness: BrightnessViewModel(
                deps: BrightnessViewModel.Dependencies(
                    lifecycleObserver: AppDependencies.live.appLifecycleObserver,
                    screen: AppDependencies.live.screen
                )
            ),
            text: TextViewModel(),
            eyedropper: EyedropperViewModel()
        )
    )
    
    init() {
        Analytics.log(AnalyticsEvent(name: "app_opened"))
    }

    var body: some Scene {
        WindowGroup {
            MainScreenView(
                viewModel: MainScreenViewModel(appState: appState),
                brightnessViewModel: appState.deps.brightness,
                textViewModel: appState.deps.text,
                eyedropperViewModel: appState.deps.eyedropper
            )
        }
    }
}
