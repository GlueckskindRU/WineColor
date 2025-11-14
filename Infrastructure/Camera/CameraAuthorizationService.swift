//
//  CameraAuthorizationService.swift
//  WineColor
//
//  Created by Yuri Ivashin on 10.11.2025.
//

import AVFoundation

enum CameraAuthorizationService {
    static func requestIfNeeded() async -> CameraPermissionState {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return .authorized
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            return granted ? .authorized : .denied
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        @unknown default:
            return .denied
        }
    }
}
