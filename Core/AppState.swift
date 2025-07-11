//
//  AppState.swift
//  WineColor
//
//  Created by Yuri Ivashin on 08.07.2025.
//

import SwiftUI

// MARK: - Nested types

extension AppState {
    struct Context {
        let initialActiveMode: ActiveMode
    }
    
    struct Dependencies {
        let brightness: BrightnessViewModel
        let text: TextViewModel
        let eyedropper: EyedropperViewModel
    }
}

// MARK: - AppState

@MainActor
final class AppState: ObservableObject {
    @Published var activeMode: ActiveMode
    private let context: Context
    let deps: Dependencies
    
    init(context: Context, deps: Dependencies) {
        self.context = context
        self.deps = deps
        activeMode = context.initialActiveMode
    }
}
