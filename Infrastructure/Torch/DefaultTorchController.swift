//
//  DefaultTorchController.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

import Foundation
import AVFoundation

struct DefaultTorchController: TorchControllingProtocol {
    public func setTorch(_ on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video),
              device.hasTorch else { return }

        try? device.lockForConfiguration()
        device.torchMode = on ? .on : .off
        device.unlockForConfiguration()
    }
    
    public func isTorchActuallyOn() -> Bool {
        guard let device = AVCaptureDevice.default(for: .video) else { return false }
        return device.isTorchActive
    }
}
