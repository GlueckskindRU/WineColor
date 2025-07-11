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
        let mockCenter = NotificationCenterMock()
        let observer = AppLifecycleObserver(notificationCenter: mockCenter)

        let foregroundCalled = XCTestExpectation(description: "Foreground called")
        let backgroundCalled = XCTestExpectation(description: "Background called")
        
        observer.observe(
            onForeground: {
                foregroundCalled.fulfill()
            },
            onBackground: {
                backgroundCalled.fulfill()
            }
        )

        mockCenter.post(name: Notification.Name(UIApplication.willEnterForegroundNotification.rawValue))
        mockCenter.post(name: Notification.Name(UIApplication.willResignActiveNotification.rawValue))


        wait(for: [foregroundCalled, backgroundCalled], timeout: 1.0)
    }
}
