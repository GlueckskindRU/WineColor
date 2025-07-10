//
//  WineColorApp.swift
//  WineColor
//
//  Created by Yuri Ivashin on 31.05.2025.
//

import SwiftUI

@main
struct WineColorApp: App {
    @StateObject private var appState = AppState()
    
    init() {
        Analytics.log(AnalyticsEvent(name: "app_opened"))
    }

    var body: some Scene {
        WindowGroup {
            MainScreenView(
                viewModel: MainScreenViewModel(appState: appState),
                brightnessViewModel: appState.brightness,
                textViewModel: appState.text,
                eyedropperViewModel: appState.eyedropper
            )
        }
    }
}
