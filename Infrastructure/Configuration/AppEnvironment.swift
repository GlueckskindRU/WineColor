//
//  AppEnvironment.swift
//  WineColor
//
//  Created by Yuri Ivashin on 31.05.2025.
//

import Foundation

enum AppEnvironment {
    case debug
    case release

    static var current: AppEnvironment {
#if DEBUG
        return .debug
#else
        return .release
#endif
    }
}
