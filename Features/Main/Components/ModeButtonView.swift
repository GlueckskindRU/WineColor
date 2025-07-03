//
//  ModeButtonView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import SwiftUI

struct ModeButtonView: View {
    let isSelected: Bool
    let color: Color
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 48, height: 48)
                    .overlay(Circle().stroke(Color.black, lineWidth: isSelected ? 2 : 0))

                if label.isNotEmpty {
                    Text(label)
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }
        .buttonStyle(.plain)
        .shadow(radius: isSelected ? 3 : 0)
    }
}
