//
//  ControlPanelWithSlidingEnabledView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 11.07.2025.
//

import SwiftUI

struct ControlPanelWithSlidingEnabledView: View {
    @Binding var activeMode: ActiveMode
    @ObservedObject var brightnessViewModel: BrightnessViewModel
    @ObservedObject var textViewModel: TextViewModel
    
    var body: some View {
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
}
