//
//  ControlPanelView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import SwiftUI

struct ControlPanelView: View {
    @Binding var activeMode: ActiveMode
    @ObservedObject var brightnessViewModel: BrightnessViewModel
    @ObservedObject var textViewModel: TextViewModel
    @ObservedObject var eyedropperViewModel: EyedropperViewModel

    var body: some View {
        VStack(spacing: 20) {
            switch activeMode {
                case .brightness, .text:
                    ControlPanelWithSlidingEnabledView(
                        activeMode: $activeMode,
                        brightnessViewModel: brightnessViewModel,
                        textViewModel: textViewModel
                    )
                case .eyedropper:
                    ControlPanelEyedropperModeView(
                        eyedropperViewModel: eyedropperViewModel
                    )
            }
            HStack {
                ForEach(ActiveMode.allCases, id: \.self) { mode in
                    ControlButtonView(mode: mode, selectedMode: $activeMode)
                }
            }
            .padding(.top, 4)
            .padding(.horizontal, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemGray5), lineWidth: 2)
            )
        }
    }
}
