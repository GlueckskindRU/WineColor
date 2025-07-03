//
//  LargeThumbSlider.swift
//  WineColor
//
//  Created by Yuri Ivashin on 03.07.2025.
//

import SwiftUI

struct LargeThumbSlider: View {
    @Binding var value: CGFloat
    let range: ClosedRange<CGFloat>
    let thumbSize: CGFloat
    let trackHeight: CGFloat

    init(value: Binding<CGFloat>, range: ClosedRange<CGFloat>, thumbSize: CGFloat = 32, trackHeight: CGFloat = 6) {
        self._value = value
        self.range = range
        self.thumbSize = thumbSize
        self.trackHeight = trackHeight
    }

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let clampedValue = min(max(value, range.lowerBound), range.upperBound)
            let sliderPosition = CGFloat((clampedValue - range.lowerBound) / (range.upperBound - range.lowerBound)) * width

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: trackHeight)

                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: sliderPosition, height: trackHeight)

                Circle()
                    .fill(Color.white)
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: sliderPosition - thumbSize / 2)
                    .shadow(radius: 3)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let newLocation = gesture.location.x
                                let percent = min(max(newLocation / width, 0), 1)
                                let newValue = Double(percent) * (range.upperBound - range.lowerBound) + range.lowerBound
                                self.value = newValue
                            }
                    )
            }
        }
        .frame(height: thumbSize)
    }
}
