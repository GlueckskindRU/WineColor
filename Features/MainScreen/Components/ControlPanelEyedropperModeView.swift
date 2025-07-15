//
//  ControlPanelEyedropperModeView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 11.07.2025.
//

import SwiftUI

struct ControlPanelEyedropperModeView: View {
    @ObservedObject var eyedropperViewModel: EyedropperViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                eyedropperViewModel.toggleTorch()
            }) {
                VStack(spacing: 4) {
                    Image(systemName: eyedropperViewModel.isTorchOn ? "bolt.fill" : "bolt.slash.fill")
                        .font(.system(size: 24, weight: .regular))
                    Text(eyedropperViewModel.isTorchOn
                         ? L10n.Button.TorchSwitcher.Off.title
                         : L10n.Button.TorchSwitcher.On.title
                    )
                    .font(.footnote)
                }
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity)
            }
            
            Button(action: {
                eyedropperViewModel.captureColor()
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "scope")
                        .font(.system(size: 24, weight: .regular))
                    Text(L10n.Button.RecognizeColor.title)
                        .font(.footnote)
                }
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(UIColor.systemGray5), lineWidth: 2)
        )
    }
}
