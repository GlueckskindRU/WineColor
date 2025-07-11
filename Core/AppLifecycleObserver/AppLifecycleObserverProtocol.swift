//
//  AppLifecycleObserverProtocol.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 10.07.2025.
//

public protocol AppLifecycleObserverProtocol: AnyObject {
    @MainActor
    func observe(
        onForeground: @escaping () -> Void,
        onBackground: @escaping () -> Void
    )
}
