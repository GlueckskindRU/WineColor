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
    @Published var capturedColor: UIColor? = nil

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
        print("🔍 Обработка захвата цвета — заглушка")
        // capturedColor = ...
    }

    func hideDisclaimer() {
        needToShowDisclaimer = false
    }
}
