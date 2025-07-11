//
//  NotificationCenter.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 10.07.2025.
//

import Foundation
import Combine

extension NotificationCenter: NotificationPublishing {
    public func publisher(
        for name: Notification.Name,
        object obj: AnyObject?
    ) -> AnyPublisher<Notification, Never> {
        Foundation.NotificationCenter
            .Publisher(center: self, name: name, object: obj)
            .eraseToAnyPublisher()
    }
}
