//
//  CameraSession.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

@preconcurrency import AVFoundation
import SwiftUI

// MARK: - Camera Session Singleton

final class CameraSession: NSObject, @unchecked Sendable {
    static let shared = CameraSession()

    let session = AVCaptureSession()

    private let sessionQueue = DispatchQueue(label: "camera.session.queue")
    private let videoQueue   = DispatchQueue(label: "camera.video.queue")
    private var isConfigured = false
    private var areObserversInstalled = false

    private var shouldCaptureColor = false
    private var colorCaptureCompletion: ((Color?) -> Void)?
    
    private let preferredDeviceTypes: [AVCaptureDevice.DeviceType] = [
        .builtInWideAngleCamera,
        .builtInDualCamera,
        .builtInDualWideCamera,
        .builtInTripleCamera
    ]

    private override init() {
        super.init()
        #if targetEnvironment(simulator)
        Analytics.log(AnalyticsEvent(name: "⚠️ Камера не доступна в симуляторе"))
        #endif
    }
    
    func configureIfNeeded() async {
        await withCheckedContinuation { continuation in
            sessionQueue.async { [weak self] in
                guard let self else {
                    continuation.resume()
                    return
                }

                // единственная точка чтения флага, на sessionQueue
                if self.isConfigured {
                    continuation.resume()
                    return
                }

                self.installObservers()
                
                let localSession = self.session
                localSession.beginConfiguration()
                defer { localSession.commitConfiguration() }

                localSession.sessionPreset = .photo

                guard
                    let camera = self.backCamera(),
                    let input = try? AVCaptureDeviceInput(device: camera),
                    localSession.canAddInput(input)
                else {
                    Analytics.log(AnalyticsEvent(name: "⚠️ Камера не найдена или не может быть добавлена."))
                    continuation.resume()
                    return
                }

                localSession.addInput(input)

                self.setupVideoOutput(on: localSession)
                self.isConfigured = true
                continuation.resume()
            }
        }
    }


    /// Запускает сессию только при наличии разрешения.
    func startIfAuthorized(_ permission: CameraPermissionState) async {
        guard permission == .authorized else { return }
        await start()
    }

    func start() async {
        if !isConfigured {
            await configureIfNeeded()
        }

        await withCheckedContinuation { cont in
            sessionQueue.async {
                guard !self.session.isRunning else {
                    cont.resume()
                    return
                }
                self.session.startRunning()
                cont.resume()
            }
        }
    }
    
    func stop() async {
        await withCheckedContinuation { cont in
            sessionQueue.async {
                guard self.session.isRunning else {
                    cont.resume()
                    return
                }
                self.session.stopRunning()
                cont.resume()
            }
        }
    }

    private func stopSyncIfRunning() {
        sessionQueue.sync {
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }

    deinit {
        stopSyncIfRunning()
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension CameraSession: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureColor(completion: @escaping (Color?) -> Void) {
        colorCaptureCompletion = completion
        shouldCaptureColor = true
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
            guard let self, self.shouldCaptureColor else { return }
            self.shouldCaptureColor = false
            let color = ColorExtractor.extractCenterPixelColor(from: image)
            self.colorCaptureCompletion?(color)
            self.colorCaptureCompletion = nil
        }
    }
}

// MARK: - Private

private extension CameraSession {
    func backCamera() -> AVCaptureDevice? {
        let fromList = preferredDeviceTypes
            .compactMap { AVCaptureDevice.default($0, for: .video, position: .back) }
            .first

        return fromList ?? AVCaptureDevice.default(for: .video)
    }
    
    func setupVideoOutput(on session: AVCaptureSession) {
        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]
        output.setSampleBufferDelegate(self, queue: videoQueue)

        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        if
            let outputConnection = output.connection(with: .video),
            outputConnection.isVideoOrientationSupported
        {
            outputConnection.videoOrientation = .portrait
        }
    }
    
    func installObservers() {
        guard !areObserversInstalled else { return }
        areObserversInstalled = true
        
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            forName: .AVCaptureSessionWasInterrupted,
            object: session,
            queue: nil
        ) { [weak self] note in
            guard let self else { return }
            let reason = note.userInfo?[AVCaptureSessionInterruptionReasonKey] as? Int
            Analytics.log(AnalyticsEvent(name: "⚠️ Сессия камеры прервана. reason: \(reason ?? -1)"))
            // Здесь можно уведомить ViewModel, если нужно отобразить оверлей
        }

        notificationCenter.addObserver(
            forName: .AVCaptureSessionInterruptionEnded,
            object: session,
            queue: nil
        ) { [weak self] _ in
            Analytics.log(AnalyticsEvent(name: "✅ Сессия камеры возобновилась"))
            Task { await self?.start() }
        }

        notificationCenter.addObserver(
            forName: .AVCaptureSessionRuntimeError,
            object: session,
            queue: nil
        ) { [weak self] note in
            Analytics.log(AnalyticsEvent(name: "💥 Ошибка камеры: <\(note.debugDescription)>"))
            Task {
                await self?.stop()
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await self?.start()
            }
        }
    }
}
