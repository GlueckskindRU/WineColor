//
//  MainScreenView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject var viewModel: MainScreenViewModel
    let brightnessViewModel: BrightnessViewModel
    let textViewModel: TextViewModel
    let eyedropperViewModel: EyedropperViewModel
    
    var body: some View {
        ZStack {
            // Фон
            viewModel.backgroundColor
                .ignoresSafeArea()

            // Камера
            if viewModel.isEyedropperMode {
                EyedropperView(viewModel: eyedropperViewModel)
            }

            // Текст
            if viewModel.isTextMode {
                Text(viewModel.placeholderText)
                    .font(viewModel.font)
                    .foregroundColor(.black.opacity(0.8))
                    .padding()
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 30)
            }
             // Нижняя панель управления
            VStack(spacing: 12) {
                 Spacer()
                 ControlPanelView(
                    activeMode: $viewModel.mode,
                    brightnessViewModel: brightnessViewModel,
                    textViewModel: textViewModel,
                    eyedropperViewModel: eyedropperViewModel
                 )
                 .background(.white)
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
    }
}
