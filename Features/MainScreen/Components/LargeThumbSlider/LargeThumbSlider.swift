//
//  LargeThumbSlider.swift
//  WineColor
//
//  Created by Yuri Ivashin on 03.07.2025.
//

import SwiftUI

struct LargeThumbSlider: View {
    @Binding var value: CGFloat
    let config: Config
    let hapticImpactGenerator: HapticImpactGeneratorProtocol

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let clamped = value.clamped(to: config.range)
            let progress = (clamped - config.range.lowerBound) / (config.range.upperBound - config.range.lowerBound)
            let sliderPosition = progress * width

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: config.trackHeight)

                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: sliderPosition, height: config.trackHeight)

                Circle()
                    .fill(Color.white)
                    .frame(width: config.thumbSize, height: config.thumbSize)
                    .offset(x: sliderPosition - config.thumbSize / 2)
                    .shadow(radius: 3)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let newLocation = gesture.location.x
                                let percent = (newLocation / width).clamped(to: 0...1)
                                value = percent * (config.range.upperBound - config.range.lowerBound) + config.range.lowerBound
                            }
                            .onEnded { _ in
                                hapticImpactGenerator.occurs(.light)
                            }
                    )
            }
        }
        .frame(height: config.thumbSize)
    }
}
