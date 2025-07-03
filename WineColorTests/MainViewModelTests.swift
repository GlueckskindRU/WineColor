//
//  MainViewModelTests.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import XCTest
@testable import WineColor

@MainActor
final class MainViewModelTests: XCTestCase {

    func testDefaultModeIsNone() {
        let viewModel = MainViewModel()
        XCTAssertEqual(viewModel.mode, .none)
        XCTAssertTrue(viewModel.isBrightnessMode)
    }

    func testToggleTextMode() {
        let viewModel = MainViewModel()

        viewModel.mode = .text
        XCTAssertTrue(viewModel.isTextMode)
        XCTAssertFalse(viewModel.isWineMode)
        XCTAssertFalse(viewModel.isBrightnessMode)
    }

    func testSliderAffectsBrightnessWhenInNoneMode() {
        let viewModel = MainViewModel()
        viewModel.mode = .none

        viewModel.sliderValue.wrappedValue = 0.3
        XCTAssertEqual(viewModel.brightness, 0.3)
    }

    func testSliderAffectsTextScaleInTextMode() {
        let viewModel = MainViewModel()
        viewModel.mode = .text

        viewModel.sliderValue.wrappedValue = 0.75
        XCTAssertEqual(viewModel.textScale, 0.75)
    }

    func testSliderAffectsPalettePositionInWineMode() {
        let viewModel = MainViewModel()
        viewModel.mode = .wine(.rose)

        viewModel.sliderValue.wrappedValue = 0.1
        XCTAssertEqual(viewModel.palettePosition, 0.1)
    }
}
