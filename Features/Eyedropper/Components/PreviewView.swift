//
//  PreviewView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

import UIKit.UIView
import AVFoundation

final class PreviewView: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
