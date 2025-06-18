//
//  AppLifecycleObserverTests.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import XCTest
@testable import WineColor

@MainActor
final class AppLifecycleObserverTests: XCTestCase {

    func testLifecycleObserverCallsHandlers() {
        let nc = NotificationCenter()
        let observer = AppLifecycleObserver(notificationCenter: nc)

        var didEnterBackground = false
        var didEnterForeground = false

        observer.observe(
            onForeground: { didEnterForeground = true },
            onBackground: { didEnterBackground = true }
        )

        nc.post(name: UIApplication.willResignActiveNotification, object: nil)
        nc.post(name: UIApplication.willEnterForegroundNotification, object: nil)

        XCTAssertTrue(didEnterBackground)
        XCTAssertTrue(didEnterForeground)
    }
}
