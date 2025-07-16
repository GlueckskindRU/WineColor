//
//  ControlButtonView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 08.07.2025.
//

import SwiftUI

struct ControlButtonView: View {
    let mode: ActiveMode
    let hapticImpactGenerator: HapticImpactGeneratorProtocol
    @Binding var selectedMode: ActiveMode

    private var isSelected: Bool {
        selectedMode == mode
    }

    var body: some View {
        Button(action: {
            hapticImpactGenerator.occurs(.light)
            selectedMode = mode
        }) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? mode.iconSelected : mode.icon)
                    .font(.system(size: 30, weight: .regular))
                Text(mode.title)
                    .font(.footnote)
            }
            .foregroundColor(isSelected ? .black : .primary)
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}
