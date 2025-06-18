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
        VStack(spacing: 12) {
            // Кнопки режимов
            HStack {
                ForEach(WineType.allCases) { type in
                    ModeButtonView(
                        isSelected: viewModel.selectedWineType == type,
                        color: WinePalettes.palette(for: type).color(at: 0.5),
                        label: .empty
                    ) {
                        viewModel.mode = viewModel.selectedWineType == type ? .none : .wine(type)
                    }
                    Spacer(minLength: .zero)
                }

                ModeButtonView(
                    isSelected: viewModel.isTextMode,
                    color: .white,
                    label: "T"
                ) {
                    viewModel.mode = viewModel.isTextMode ? .none : .text
                }
            }
            .frame(maxWidth: .infinity)

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        viewModel.gradient.map { AnyShapeStyle($0) } ?? AnyShapeStyle(Color.clear)
                    )
                    .frame(height: 32)
                Slider(value: viewModel.sliderValue, in: 0...1)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
