//
//  CameraSession.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

@preconcurrency import AVFoundation

// MARK: - Camera Session Singleton

@MainActor
final class CameraSession {
    @MainActor
    static let shared = CameraSession()
    let session = AVCaptureSession()

    private init() {
        #if targetEnvironment(simulator)
        print("⚠️ Камера не доступна в симуляторе")
        return
        #endif

        session.beginConfiguration()
        
        // Camera input
        if
            let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        {
            session.addInput(input)
        }

        session.commitConfiguration()
        // ✅ Сохраняем ссылку локально на главном потоке:
        let localSession = session
        // ✅ Используем уже НЕ @MainActor-путь
        DispatchQueue.global(qos: .userInitiated).async {
            localSession.startRunning()
        }
    }
}
