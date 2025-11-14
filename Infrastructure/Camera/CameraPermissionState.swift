//
//  CameraPermissionState.swift
//  WineColor
//
//  Created by Yuri Ivashin on 10.11.2025.
//

import AVFoundation

enum CameraPermissionState: Equatable {
    case authorized
    case denied
    case restricted
    case notDetermined
}
