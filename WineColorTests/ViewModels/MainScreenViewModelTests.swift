//
//  MainScreenViewModelTests.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 10.07.2025.
//

import XCTest
import SwiftUI
@testable import WineColor

@MainActor
final class MainScreenViewModelTests: XCTestCase {
    func testModeChecks() {
        let appState = makeAppState(fontSize: 0.5, mode: .brightness)
        let viewModel = MainScreenViewModel(appState: appState)

        XCTAssertTrue(viewModel.isBrightnessMode)
        XCTAssertFalse(viewModel.isTextMode)
        XCTAssertFalse(viewModel.isEyedropperMode)
        
        viewModel.mode = .text
        
        XCTAssertTrue(viewModel.isTextMode)
        XCTAssertFalse(viewModel.isBrightnessMode)
        XCTAssertFalse(viewModel.isEyedropperMode)
    }

    func testFontCalculation() {
        let appState = makeAppState(fontSize: TestData.minFontSizeCoefficient, mode: .text)
        let viewModel = MainScreenViewModel(appState: appState)
        XCTAssertEqual(viewModel.fontSize, TestData.minFontSize)

        appState.deps.text.fontSize = TestData.maxFontSizeCoefficient
        // принудительно уведомим об изменении
        viewModel.objectWillChange.send()
        XCTAssertEqual(viewModel.fontSize, TestData.maxFontSize)
    }

    func testFontUpdatesOnFontSizeChange() async throws {
        let appState = makeAppState(fontSize: 0.25, mode: .text)
        let viewModel = MainScreenViewModel(appState: appState)

        XCTAssertEqual(viewModel.fontSize, customFontSize(basedOn: 0.25))

        appState.deps.text.fontSize = 0.75
        viewModel.objectWillChange.send()
        XCTAssertEqual(viewModel.fontSize, customFontSize(basedOn: 0.75))
    }
}

private extension MainScreenViewModelTests {
    func makeAppState(
        fontSize: CGFloat,
        mode: ActiveMode
    ) -> AppState {
        let textViewModel = TextViewModel()
        textViewModel.fontSize = fontSize
        return AppState(
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
                text: textViewModel,
                eyedropper: EyedropperViewModel(
                    torchController: TorchControllerMock(),
                    hapticImpactGenerator: HapticImpactGeneratorMock()
                )
            )
        )
    }
    
    func customFontSize(basedOn coefficient: CGFloat) -> CGFloat {
        TestData.minFontSize + ((TestData.maxFontSize - TestData.minFontSize) * coefficient)
    }
    
    enum TestData {
        static let minFontSize: CGFloat = 14
        static let minFontSizeCoefficient: CGFloat = .zero
        static let maxFontSize: CGFloat = 40
        static let maxFontSizeCoefficient: CGFloat = 1
    }
}
