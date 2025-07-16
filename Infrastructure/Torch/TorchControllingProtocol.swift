//
//  TorchControllingProtocol.swift
//  WineColor
//
//  Created by Yuri Ivashin on 13.07.2025.
//

import Foundation

public protocol TorchControllingProtocol {
    func setTorch(_ on: Bool)
    func isTorchActuallyOn() -> Bool
}
