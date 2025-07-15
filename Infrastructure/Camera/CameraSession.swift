//
//  CameraSession.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

@preconcurrency import AVFoundation
import SwiftUI

// MARK: - Camera Session Singleton

@MainActor
final class CameraSession: NSObject {
    @MainActor
    static let shared = CameraSession()
    let session = AVCaptureSession()
    
    private var shouldCaptureColor = false
    private var colorCaptureCompletion: ((Color?) -> Void)?

    private override init() {
        #if targetEnvironment(simulator)
        print("⚠️ Камера не доступна в симуляторе")
        return
        #endif
        
        super.init()
        
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
        self.setupVideoOutput()
        // ✅ Сохраняем ссылку локально на главном потоке:
        let localSession = session
        // ✅ Используем уже НЕ @MainActor-путь
        DispatchQueue.global(qos: .userInitiated).async {
            localSession.startRunning()
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension CameraSession: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureColor(completion: @escaping (Color?) -> Void) {
        self.colorCaptureCompletion = completion
        self.shouldCaptureColor = true
    }

    nonisolated public func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let image = ColorExtractor.sampleBufferToUIImage(sampleBuffer) else {
            DispatchQueue.main.async { [weak self] in
                self?.colorCaptureCompletion?(nil)
                self?.colorCaptureCompletion = nil
            }
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard self.shouldCaptureColor else { return }

            self.shouldCaptureColor = false
            let color = ColorExtractor.extractCenterPixelColor(from: image)
            self.colorCaptureCompletion?(color)
            self.colorCaptureCompletion = nil
        }
    }
}

// MARK: - Private methods

private extension CameraSession {
    var videoQueue: DispatchQueue {
        return DispatchQueue(label: "camera.video.queue")
    }

    func setupVideoOutput() {
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)

        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
    }
}
