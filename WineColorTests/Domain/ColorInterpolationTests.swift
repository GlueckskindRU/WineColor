//
//  ColorInterpolationTests.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import XCTest
import SwiftUI
@testable import WineColor

final class ColorInterpolationTests: XCTestCase {
    
    func testColorInterpolationMidpoint() {
        let red = Color(red: 1, green: 0, blue: 0)
        let blue = Color(red: 0, green: 0, blue: 1)
        let mid = Color.interpolatedColor(from: red, to: blue, progress: 0.5)

        let uiMid = UIColor(mid)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiMid.getRed(&r, green: &g, blue: &b, alpha: &a)

        XCTAssertEqual(r, 0.5, accuracy: 0.01)
        XCTAssertEqual(g, 0.0, accuracy: 0.01)
        XCTAssertEqual(b, 0.5, accuracy: 0.01)
        XCTAssertEqual(a, 1.0, accuracy: 0.01)
    }
}

