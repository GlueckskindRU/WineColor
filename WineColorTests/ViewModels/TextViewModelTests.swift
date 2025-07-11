//
//  TextViewModelTests.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 11.07.2025.
//

import XCTest
import Combine
@testable import WineColor

@MainActor
final class TextViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testInitialFontSize() {
        let sut = TextViewModel()
        XCTAssertEqual(sut.fontSize, 0.5)
    }

    func testFontSizeCanBeSet() {
        let sut = TextViewModel()
        sut.fontSize = 0.75
        XCTAssertEqual(sut.fontSize, 0.75)
    }

    func testFontSizePublishesChanges() {
        let sut = TextViewModel()
        let expectation = XCTestExpectation(description: "Should publish font size change")

        var receivedValues: [CGFloat] = []

        sut.$fontSize
            .dropFirst() // skip initial
            .sink { value in
                receivedValues.append(value)
                if receivedValues.count == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.fontSize = 0.25
        sut.fontSize = 0.9

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedValues, [0.25, 0.9])
    }
}
