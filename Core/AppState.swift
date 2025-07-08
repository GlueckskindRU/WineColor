//
//  AppState.swift
//  WineColor
//
//  Created by Yuri Ivashin on 08.07.2025.
//

import SwiftUI

@MainActor
final class AppState: ObservableObject {
    let brightness: BrightnessViewModel
    let text: TextViewModel
    let eyedropper: EyedropperViewModel

    @Published var activeMode: ActiveMode

    init(
        brightness: BrightnessViewModel = BrightnessViewModel(),
        text: TextViewModel = TextViewModel(),
        eyedropper: EyedropperViewModel = EyedropperViewModel(),
        activeMode: ActiveMode = .brightness
    ) {
        self.brightness = brightness
        self.text = text
        self.eyedropper = eyedropper
        self.activeMode = activeMode
    }
}
