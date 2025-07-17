//
//  AppStateTests.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 11.07.2025.
//

import XCTest
import Combine
@testable import WineColor

@MainActor
final class AppStateTests: XCTestCase {

    func testInitialValues() {
        let appState = AppState(
            context: AppState.Context(
                initialActiveMode: .brightness
            ),
            deps: AppState.Dependencies(
                brightness: BrightnessViewModel(
                    deps: BrightnessViewModel.Dependencies(
                        lifecycleObserver: AppLifecycleObserverMock(),
                        screen: UIScreenMock()
                    )
                ),
                text: TextViewModel(),
                eyedropper: EyedropperViewModel(
                    torchController: TorchControllerMock(),
                    hapticImpactGenerator: HapticImpactGeneratorMock()
                )
            )
        )

        XCTAssertEqual(appState.activeMode, .brightness)
    }

    func testActiveModeCanBeChanged() {
        let appState = AppState(
            context: AppState.Context(
                initialActiveMode: .brightness
            ),
            deps: AppState.Dependencies(
                brightness: BrightnessViewModel(
                    deps: BrightnessViewModel.Dependencies(
                        lifecycleObserver: AppLifecycleObserverMock(),
                        screen: UIScreenMock()
                    )
                ),
                text: TextViewModel(),
                eyedropper: EyedropperViewModel(
                    torchController: TorchControllerMock(),
                    hapticImpactGenerator: HapticImpactGeneratorMock()
                )
            )
        )
        appState.activeMode = .text
        XCTAssertEqual(appState.activeMode, .text)
    }

    func testActiveModePublishesChanges() {
        let appState = AppState(
            context: AppState.Context(
                initialActiveMode: .brightness
            ),
            deps: AppState.Dependencies(
                brightness: BrightnessViewModel(
                    deps: BrightnessViewModel.Dependencies(
                        lifecycleObserver: AppLifecycleObserverMock(),
                        screen: UIScreenMock()
                    )
                ),
                text: TextViewModel(),
                eyedropper: EyedropperViewModel(
                    torchController: TorchControllerMock(),
                    hapticImpactGenerator: HapticImpactGeneratorMock()
                )
            )
        )
        var received: [ActiveMode] = []
        let expectation = XCTestExpectation(description: "Observed activeMode changes")

        let cancellable = appState.$activeMode
            .dropFirst()
            .sink { mode in
                received.append(mode)
                if received.count == 2 {
                    expectation.fulfill()
                }
            }

        appState.activeMode = .text
        appState.activeMode = .eyedropper

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(received, [.text, .eyedropper])
        cancellable.cancel()
    }
}
