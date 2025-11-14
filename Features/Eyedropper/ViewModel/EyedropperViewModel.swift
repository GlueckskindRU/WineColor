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
    @Published private(set) var permission: CameraPermissionState = .notDetermined
    var canUseCamera: Bool { permission == .authorized }
    var captureSession: AVCaptureSession { CameraSession.shared.session }

    private let torchController: TorchControllingProtocol
    private let hapticImpactGenerator: HapticImpactGeneratorProtocol
    private var didRequestPermission = false
    private var hasStarted = false

    init(
        torchController: TorchControllingProtocol,
        hapticImpactGenerator: HapticImpactGeneratorProtocol
    ) {
        self.torchController = torchController
        self.hapticImpactGenerator = hapticImpactGenerator
    }
    
    func onAppearOnce() {
        guard !didRequestPermission else { return }
        didRequestPermission = true

        Task { [weak self] in
            guard let self else { return }
            self.permission = await CameraAuthorizationService.requestIfNeeded()
        }
    }

    func handleScenePhase(_ phase: ScenePhase) async {
        switch phase {
        case .active:
            await CameraSession.shared.startIfAuthorized(permission)
        case .inactive, .background:
            await CameraSession.shared.stop()
        @unknown default:
            await CameraSession.shared.stop()
        }
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
    
    /// Запросить/проверить доступ и запустить камеру, если можно
    func ensureCameraRunning() async {
        guard !hasStarted else { return }
        hasStarted = true
        defer { hasStarted = false }

        let status = await CameraAuthorizationService.requestIfNeeded()
        if status == .authorized {
            await CameraSession.shared.start()
        }
    }
    
    /// Остановить камеру, если она запущена
    func stopCameraIfNeeded() {
        Task { @MainActor in
            await CameraSession.shared.stop()
        }
    }
    
    // MARK: - Private methods
    
    private func syncTorchStateWithHardware() {
        isTorchOn = torchController.isTorchActuallyOn()
    }
}
