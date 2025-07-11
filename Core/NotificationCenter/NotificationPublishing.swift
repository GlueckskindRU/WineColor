//
//  NotificationPublishing.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 10.07.2025.
//

import Foundation
import Combine

public protocol NotificationPublishing: AnyObject {
    func publisher(
        for name: Notification.Name,
        object obj: AnyObject?
    ) -> AnyPublisher<Notification, Never>
}
