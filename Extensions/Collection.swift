//
//  Collection.swift
//  WineColor
//
//  Created by Yuri Ivashin on 01.06.2025.
//

import Foundation

extension Collection where Element: Equatable {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func next(after element: Element) -> Element? {
        guard let index = firstIndex(of: element) else { return nil }
        let nextIndex = self.index(after: index)
        return nextIndex < endIndex ? self[nextIndex] : nil
    }

    func previous(before element: Element) -> Element? {
        guard let index = firstIndex(of: element), index > startIndex else { return nil }
        let previousIndex = self.index(index, offsetBy: -1)
        return self[previousIndex]
    }
}
