//
//  NotificationCenterMock.swift
//  WineColorTests
//
//  Created by Yuri Ivashin on 10.07.2025.
//

import Foundation
import Combine
import WineColor

final class NotificationCenterMock: NotificationPublishing, @unchecked Sendable {
    // MARK: - Combine subjects
    private var subjects: [Notification.Name: PassthroughSubject<Notification, Never>] = [:]

    // MARK: - Logging & Tracking
    private(set) var publisherForObjectWasCalled: Int = .zero
    private(set) var publisherForObjectReceivedArguments: (name: Notification.Name, object: AnyObject?)?

    private(set) var postNameObjectUserInfoWasCalled: Int = .zero
    private(set) var postCallLog: [Notification] = []

    // MARK: - Publisher
    func publisher(
        for name: Notification.Name,
        object obj: AnyObject?
    ) -> AnyPublisher<Notification, Never> {
        publisherForObjectWasCalled += 1
        publisherForObjectReceivedArguments = (name: name, object: obj)

        let subject = subjects[name] ?? {
            let newSubject = PassthroughSubject<Notification, Never>()
            subjects[name] = newSubject
            return newSubject
        }()
        return subject.eraseToAnyPublisher()
    }
    
    // MARK: - Manual post for triggering subscribers
    func post(
        name: Notification.Name,
        object: AnyObject? = nil,
        userInfo: [AnyHashable: Any]? = nil
    ) {
        let notification = Notification(name: name, object: object, userInfo: userInfo)
        postNameObjectUserInfoWasCalled += 1
        postCallLog.append(notification)

        subjects[name]?.send(notification)
    }
}
