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
    let hapticImpactGenerator: HapticImpactGeneratorProtocol
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Фон
                viewModel.backgroundColor
                    .ignoresSafeArea()
                
                // Камера
                if viewModel.isEyedropperMode {
                    EyedropperView(viewModel: eyedropperViewModel)
                }

                // Текст
                if
                    viewModel.isTextMode,
                    let attributedText = viewModel.aboutAppText
                {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text(attributedText)
                                .font(viewModel.font)
                                .foregroundColor(.black.opacity(0.8))
                                .multilineTextAlignment(.leading)
                                .padding()
                                .padding(.bottom, 30)
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(.top, 1)
                }
            }
            // Панель управления внизу
            ControlPanelView(
                activeMode: $viewModel.mode,
                brightnessViewModel: brightnessViewModel,
                textViewModel: textViewModel,
                eyedropperViewModel: eyedropperViewModel,
                hapticImpactGenerator: hapticImpactGenerator
            )
            .background(.white)
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
    }
}
