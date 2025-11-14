//
//  CameraUnavailableView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 10.11.2025.
//

import SwiftUI

struct CameraUnavailableView: View {
    let permission: CameraPermissionState

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "bolt.slash")
                .font(.system(size: 40))
                .foregroundColor(.gray)

            Text(title)
                .font(.headline)
                .foregroundColor(.gray)

            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .foregroundColor(.gray)
            
            if permission == .denied {
                Button(action: openSettings) {
                    Text(L10n.Button.OpenSettings.title)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(8)
                }
                .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.05))
    }

    private var title: String {
        switch permission {
            case .denied:           return L10n.CameraPermission.Denied.title
            case .restricted:       return L10n.CameraPermission.Restricted.title
            case .notDetermined:    return L10n.CameraPermission.NotDetermined.title
            case .authorized:       return .empty
        }
    }

    private var message: String {
        switch permission {
        case .denied:
            return L10n.CameraPermission.Denied.message
        case .restricted:
            return L10n.CameraPermission.Restricted.message
        case .notDetermined:
            return L10n.CameraPermission.NotDetermined.message
        case .authorized:
            return .empty
        }
    }
    
    private func openSettings() {
        guard
            let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url)
        else { return }

        UIApplication.shared.open(url)
    }
}
