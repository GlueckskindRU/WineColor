//
//  HapticImpactGeneratorMock.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 17.07.2025.
//

import Foundation
import WineColor

final class HapticImpactGeneratorMock: HapticImpactGeneratorProtocol {
    private(set) var occursWasCalled: Int = .zero
    private(set) var occursReceivedArgument: WineColor.HapticImpact?
    
    func occurs(_ impact: WineColor.HapticImpact) {
        occursWasCalled += 1
        occursReceivedArgument = impact
    }
}
