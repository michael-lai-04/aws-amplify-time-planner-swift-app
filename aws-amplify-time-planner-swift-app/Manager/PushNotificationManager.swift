//
//  PushNotificationManager.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 3/2/2023.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error{
                print("EROOR: \(error)")
            }else{
                print("SUCCESS")
            }
        }
    }
    
    func checkAuthorization() -> String {
        var status = ""
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {
            (settings) in
            if settings.authorizationStatus == .authorized{
                status = "permitted"
            }
            if settings.authorizationStatus != .authorized {
                status = "not permitted"
            }
        }
        )
        return status
    }
    
    func scheduleNotification(notificationContent: NotificationContent){
        
        let content = UNMutableNotificationContent()
        content.title = notificationContent.title
        content.subtitle = notificationContent.subtitle
        content.sound = .default
        content.badge = 1
        
        //time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
//
        //calender
//        var dateComponent = DateComponents()
//        dateComponent.hour = 21
//        dateComponent.minute = 05


        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationContent.dateComponents, repeats: false)
            

        let request = UNNotificationRequest(identifier: UUID().uuidString
            , content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct NotificationContent {
    let title: String
    let subtitle: String
    let dateComponents: DateComponents
}
