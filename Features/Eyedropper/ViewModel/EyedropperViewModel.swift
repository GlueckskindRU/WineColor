//
//  EyedropperViewModel.swift
//  WineColor
//
//  Created by Yuri Ivashin on 08.07.2025.
//

import SwiftUI
import AVFoundation

@MainActor
final class EyedropperViewModel: ObservableObject {

    @Published var isTorchOn: Bool = false
    @Published var needToShowDisclaimer: Bool = true
    @Published var capturedColor: Color? = nil

    private let torchController: TorchControllingProtocol
    private let hapticImpactGenerator: HapticImpactGeneratorProtocol

    init(
        torchController: TorchControllingProtocol,
        hapticImpactGenerator: HapticImpactGeneratorProtocol
    ) {
        self.torchController = torchController
        self.hapticImpactGenerator = hapticImpactGenerator
    }

    func toggleTorch() {
        hapticImpactGenerator.occurs(.medium)
        isTorchOn.toggle()
        torchController.setTorch(isTorchOn)
    }

    func captureColor() {
        hapticImpactGenerator.occurs(.medium)
        CameraSession.shared.captureColor { [weak self] color in
            Task { @MainActor in
                self?.capturedColor = color
                // Подождать немного, чтобы состояние обновилось
                try? await Task.sleep(nanoseconds: 300_000_000) // 300ms
                self?.syncTorchStateWithHardware()
            }
        }
    }
    
    func resetCapturedColor() {
        hapticImpactGenerator.occurs(.light)
        capturedColor = nil
    }

    func hideDisclaimer() {
        needToShowDisclaimer = false
    }
    
    // MARK: - Private methods
    
    private func syncTorchStateWithHardware() {
        isTorchOn = torchController.isTorchActuallyOn()
    }
}
