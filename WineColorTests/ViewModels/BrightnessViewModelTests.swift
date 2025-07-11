//
//  BrightnessViewModelTests.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 11.07.2025.
//

import XCTest
import SwiftUI
@testable import WineColor

@MainActor
final class BrightnessViewModelTests: XCTestCase {

    func testInitialValueIsDefaultBrightness() {
        let sut = BrightnessViewModel()
        XCTAssertEqual(sut.value, 0.5)
    }

    func testValueUpdateStoresNewBrightness() {
        let sut = BrightnessViewModel()
        sut.value = 0.7
        XCTAssertEqual(sut.value, 0.7)
    }

    func testLifecycleRestoresBrightness() {
        let notificationCenterMock = NotificationCenterMock()
        let screenMock = UIScreenMock()
        let observer = AppLifecycleObserver(notificationCenter: notificationCenterMock)
        let sut = BrightnessViewModel(
            observer: observer,
            screen: screenMock
        )
        
        XCTAssertEqual(sut.value, 0.5)

        // Сохраняем яркость при уходе в фон
        sut.value = 0.85
        XCTAssertEqual(sut.value, 0.85)
        XCTAssertEqual(screenMock.brightness, 0.85)
        notificationCenterMock.post(
            name: Notification.Name(UIApplication.willResignActiveNotification.rawValue)
        )
        XCTAssertEqual(screenMock.brightness, 0.5)
        XCTAssertEqual(sut.value, 0.85)

        // Меняем яркость, чтобы убедиться, что восстановление сработает
        screenMock.brightness = 0.3
        notificationCenterMock.post(
            name: Notification.Name(UIApplication.willEnterForegroundNotification.rawValue)
        )
        
        XCTAssertEqual(screenMock.brightness, 0.85)
        XCTAssertEqual(sut.value, 0.85)
    }
}
