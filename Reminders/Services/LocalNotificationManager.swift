//
//  LocalNotificationManager.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/04/20.
//

import Foundation
import NotificationCenter

final class LocalNotificationManager: NSObject, ObservableObject {
    let notificationCenter = UNUserNotificationCenter.current();
    
    @Published var isGranted = false;
    @Published var nextView: ScreenType?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func requestAuthorization() async {
        do {
            try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            print(error.localizedDescription, "request authorazation error.")
        }
        await getNotificationAuthStatus();
    }
    
    func getNotificationAuthStatus() async {
        let currentSettings = await notificationCenter.notificationSettings();
        DispatchQueue.main.async { [weak self] in
            self?.isGranted = currentSettings.authorizationStatus == .authorized;
        }
    }
    
    func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    func scheduleNotification(localNotification: LocalNotification) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = localNotification.title
        notificationContent.body = localNotification.body
        notificationContent.sound = .default
        
        if let userInfo = localNotification.userInfo {
            notificationContent.userInfo = userInfo
        }
        
        if let bundleImage = localNotification.bundleImage {
            if let url = Bundle.main.url(forResource: bundleImage, withExtension: ""){
                if let attachment = try? UNNotificationAttachment(identifier: bundleImage, url: url) {
                    notificationContent.attachments = [attachment]
                }
            }
        }
        
        if localNotification.noficationType == .time {
            guard let timeInterval = localNotification.timeInterval else { return }
            let notificationTrigger = UNTimeIntervalNotificationTrigger(
                timeInterval: timeInterval,
                repeats: localNotification.notificationRepeat
            )
            
            let notificationRequest = UNNotificationRequest(
                identifier: localNotification.identifier,
                content: notificationContent,
                trigger: notificationTrigger
            )
            notificationCenter.add(notificationRequest)
        } else {
            guard let dateComponents = localNotification.dateComponents else { return }
            let notificationTrigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents,
                repeats: localNotification.notificationRepeat
            )
            
            let notificationRequest = UNNotificationRequest(
                identifier: localNotification.identifier,
                content: notificationContent,
                trigger: notificationTrigger
            )
            notificationCenter.add(notificationRequest)
        }
    }
}

extension LocalNotificationManager: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .badge, . sound]
    }
    
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if let value = response.notification.request.content.userInfo["screen_type"] as? String {
            self.nextView = ScreenType(rawValue: value)
        }
    }
}
