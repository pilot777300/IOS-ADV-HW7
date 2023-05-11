

import Foundation
import UserNotifications
import UIKit


class LocalNotificationsService {
    
    
    func registerForLatestUpdatesIfPossible() {
        requestNotificationAuthorization()
        sendNotification()
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [ .sound, .badge, .provisional]) { granted, _ in
             print("Разрешение получено: \(granted)")
           }
    }
    
    func sendNotification() {
        let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                let content = UNMutableNotificationContent()
                
                
        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
                content.title = "Проверить обновления"
                content.body = "Новое обновление в ленте!"
                content.sound = .default
                
                var dateComponents = DateComponents()
                dateComponents.hour = 19
                dateComponents.minute = 02
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
    }
}
