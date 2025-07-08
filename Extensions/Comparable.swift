//
//  Comparable.swift
//  WineColor
//
//  Created by Yuri Ivashin on 04.07.2025.
//

import SwiftUI

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
