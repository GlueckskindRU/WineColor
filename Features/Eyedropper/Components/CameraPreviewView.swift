//
//  CameraPreviewView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

import SwiftUI
import AVFoundation

struct CameraPreviewView: UIViewRepresentable {
    private let session: AVCaptureSession

    init(session: AVCaptureSession = CameraSession.shared.session) {
        self.session = session
    }

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {}
}
