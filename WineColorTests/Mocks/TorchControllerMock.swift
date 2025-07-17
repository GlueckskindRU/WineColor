//
//  TorchControllerMock.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 17.07.2025.
//

import Foundation
import WineColor

final class TorchControllerMock: TorchControllingProtocol {
    private(set) var setTorchOnWasCalled: Int = .zero
    private(set) var setTorchOnReceivedArgument: Bool?
    
    func setTorch(_ on: Bool) {
        setTorchOnWasCalled += 1
        setTorchOnReceivedArgument = on
    }
    
    private(set) var isTorchActuallyOnWasCalled: Int = .zero
    var isTorchActuallyOnStub: Bool!
    
    func isTorchActuallyOn() -> Bool {
        isTorchActuallyOnWasCalled += 1
        return isTorchActuallyOnStub
    }
}
