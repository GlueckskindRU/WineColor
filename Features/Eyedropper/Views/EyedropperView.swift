//
//  EyedropperView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

import SwiftUI

struct EyedropperView: View {
    @Environment(\.scenePhase) private var scenePhase
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
                    if viewModel.canUseCamera {
                        CameraPreviewView(session: viewModel.captureSession)
                            .frame(height: 320)
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .shadow(radius: 5)
                    } else {
                        CameraUnavailableView(permission: viewModel.permission)
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .shadow(radius: 5)
                    }
                }

                Spacer(minLength: 0)
            }
            .overlay(
                Group {
                    if
                        !viewModel.needToShowDisclaimer,
                        viewModel.capturedColor == nil,
                        viewModel.canUseCamera
                    {
                        Rectangle()
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 34, height: 34)
                    }
                }
            )

            // Добавим отступ вручную под панель
            Spacer()
                .frame(height: 275) // Подстрой под фактическую высоту ControlPanelEyedropperModeView
        }
        .onAppear {
            viewModel.onAppearOnce()
        }
        .applyAlertIfNeeded(
            viewModel.canUseCamera,
            isPresented: $viewModel.needToShowDisclaimer,
            title: L10n.EyedropperView.Alert.title,
            buttonTitle: L10n.EyedropperView.Alert.buttonTitle,
            onButton: { viewModel.hideDisclaimer() },
            message: L10n.EyedropperView.Alert.text
        )
        .task {
            // сработает при первом появлении вью; запустит сессию и при «холодном» старте, и после перезапуска приложения
            await viewModel.ensureCameraRunning()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                Task { await viewModel.ensureCameraRunning() }
            } else if phase == .inactive || phase == .background {
                viewModel.stopCameraIfNeeded()
            }
        }
        .onDisappear {
            // если пользователь ушёл с экрана — останавливаем
            viewModel.stopCameraIfNeeded()
        }
    }
}

private extension View {
    @ViewBuilder
    func applyAlertIfNeeded(
        _ canUseCamera: Bool,
        isPresented: Binding<Bool>,
        title: String,
        buttonTitle: String,
        onButton: @escaping () -> Void,
        message: String
    ) -> some View {
        if canUseCamera {
            self.alert(title, isPresented: isPresented) {
                Button(buttonTitle, action: onButton)
            } message: {
                Text(message)
            }
        } else {
            self
        }
    }
}
