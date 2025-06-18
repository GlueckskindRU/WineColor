//
//  ActiveMode.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import Foundation

enum ActiveMode: Equatable {
    case none
    case text
    case wine(WineType)

    var isBrightness: Bool {
        self == .none
    }

    var isText: Bool {
        self == .text
    }

    var isWine: Bool {
        if case .wine = self {
            return true
        }
        return false
    }

    var selectedWineType: WineType? {
        if case let .wine(type) = self {
            return type
        }
        return nil
    }
}
