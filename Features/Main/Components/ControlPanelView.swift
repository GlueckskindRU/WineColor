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
            if activeMode.isSliderEnabled {
                HStack(spacing: 12) {
                    Label(activeMode.hint, systemImage: activeMode.iconSelected)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    if activeMode.isText {
                        LargeThumbSlider(value: $textViewModel.fontSize, config: .large)
                            .frame(height: 44)
                            .padding(.horizontal)
                    } else if activeMode.isBrightness {
                        LargeThumbSlider(value: $brightnessViewModel.value, config: .large)
                            .frame(height: 44)
                            .padding(.horizontal)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.systemGray5), lineWidth: 2)
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
