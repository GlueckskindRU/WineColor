//
//  ControlPanelView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import SwiftUI

struct ControlPanelView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack(spacing: 20) {
            if !viewModel.isEyedropperMode {
                HStack(spacing: 12) {
                    Label(viewModel.mode.title, systemImage: viewModel.mode.iconSelected)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    LargeThumbSlider(value: viewModel.sliderValue, range: 0...1, thumbSize: 50)
                        .frame(height: 44) // задаёт минимальную высоту
                        .padding(.horizontal)
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
                ForEach(ControlButton.allCases, id: \.self) { button in
                    Button(action: {
                        viewModel.select(button)
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: viewModel.isSelected(button) ? button.iconSelected : button.icon)
                                .font(.system(size: 30, weight: .regular))
                            Text(button.title)
                                .font(.footnote)
                        }
                        .foregroundColor(viewModel.isSelected(button) ? .black : .primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
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
