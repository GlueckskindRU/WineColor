//
//  EyedropperView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

import SwiftUI

struct EyedropperView: View {
    @ObservedObject var viewModel: EyedropperViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Камера + перекрестие
            VStack(spacing: 8) {
                if let capturedColor = viewModel.capturedColor {
                    // Заливка цветом, если цвет получен
                    capturedColor
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .shadow(radius: 5)
                } else {
                    // Камера
                    CameraPreviewView()
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .shadow(radius: 5)
                }

                Spacer(minLength: 0)
            }
            .overlay(
                Group {
                    if
                        !viewModel.needToShowDisclaimer,
                        viewModel.capturedColor == nil
                    {
                        Rectangle()
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 75, height: 75)
                    }
                }
            )

            // Добавим отступ вручную под панель
            Spacer()
                .frame(height: 275) // Подстрой под фактическую высоту ControlPanelEyedropperModeView
        }
        .alert(L10n.EyedropperView.Alert.title, isPresented: $viewModel.needToShowDisclaimer) {
            Button(L10n.EyedropperView.Alert.buttonTitle) {
                viewModel.hideDisclaimer()
            }
        } message: {
            Text(L10n.EyedropperView.Alert.text)
        }
    }
}
