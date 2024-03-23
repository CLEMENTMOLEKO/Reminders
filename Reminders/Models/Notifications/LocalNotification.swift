//
//  LocalNotification.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/04/20.
//

import Foundation

/// LocalNotification is used to schecdule notification in LocationManager
///  It enables two types of notification, calendar notifications and time interval notification.
struct LocalNotification {
    internal init(title: String, body: String, identifier: String, dateComponents: DateComponents, notificationRepeat: Bool) {
        self.title = title
        self.body = body
        self.identifier = identifier
        self.noficationType = .calendar
        self.timeInterval = nil
        self.dateComponents = dateComponents
        self.notificationRepeat = notificationRepeat
    }
    
    internal init(title: String, body: String, identifier: String, timeInterval: Double, notificationRepeat: Bool) {
        self.title = title
        self.body = body
        self.identifier = identifier
        self.noficationType = .time
        self.timeInterval = timeInterval
        self.dateComponents = nil
        self.notificationRepeat = notificationRepeat
    }
    
    enum NotificationType {
        case time, calendar
    }
    
    let title: String
    let body: String
    let identifier: String
    var noficationType: NotificationType
    var bundleImage: String?
    var userInfo: [AnyHashable:Any]?
    let timeInterval: Double?
    let dateComponents: DateComponents?
    let notificationRepeat: Bool
}
