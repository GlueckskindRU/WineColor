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

    init(
        torchController: TorchControllingProtocol = DefaultTorchController()
    ) {
        self.torchController = torchController
    }

    func toggleTorch() {
        isTorchOn.toggle()
        torchController.setTorch(isTorchOn)
    }

    func captureColor() {
        CameraSession.shared.captureColor { [weak self] color in
            Task { @MainActor in
                self?.capturedColor = color
            }
        }
    }

    func hideDisclaimer() {
        needToShowDisclaimer = false
    }
}
