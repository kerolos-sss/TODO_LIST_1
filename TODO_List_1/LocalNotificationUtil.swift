//
//  LocalNotificationUtil.swift
//  kero_test_swift_1
//
//  Created by Kero on 2/21/17.
//  Copyright © 2017 Kero. All rights reserved.
//

import Foundation
import UserNotifications;
import UIKit


class LocalNotificationUtil{

    static let category = "reminder"
    
    class func configNotifications(){
        

        
        if #available(iOS 10.0, *) {
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge] ,completionHandler: { (granted, error) in
                // Enable or disable features based on authorization.
            })
            
        } else {
            // Fallback on earlier versions
            let inviteCategory = UIMutableUserNotificationCategory()
            inviteCategory.identifier =  category  // @"REMINDER_CATEGORY";
            
            var categories = Set<UIMutableUserNotificationCategory> ();
            categories.insert(inviteCategory)
            
            let mySettings = UIUserNotificationSettings (types: [.badge , .sound , .alert ] , categories: categories) // settingsForTypes:types categories:categories];
            
            //registering notification category and all types
            UIApplication.shared.registerUserNotificationSettings(mySettings) // sharedApplication;] registerUserNotificationSettings:mySettings];
            
        }
        
    }
    
    
class func scheduleNotificationWithUID( uid: String, userInfo: Dictionary<String, Any>, messageBody: String, title:String, category: String, fireDate: Date, isRepeating:Bool){
    
    
    // create content
        if #available(iOS 10.0, *) {
            let center =  UNUserNotificationCenter.current()

            let content = UNMutableNotificationContent()
            content.sound =  UNNotificationSound.default()
            content.title = title //@"Don't forget";
            content.body = messageBody //@"Buy some milk";
            content.categoryIdentifier = category  //@"UYLReminderCategory";
            
           
            content.userInfo = userInfo
            content.userInfo["uid"] = uid
            
            
            
            
            //UNCalendarNotificationTrigger *trigger2 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDaterepeats:isRepeating];
            let calendar = Calendar(identifier: .gregorian)
            
            let components = calendar.dateComponents(in: .current, from: fireDate)
            
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: isRepeating)
        
            //NSString *identifier = @"UYLLocalNotification";
            let request = UNNotificationRequest(identifier: uid, content: content, trigger: trigger)  // requestWithIdentifier:uid content:content trigger:trigger2];
            
            center.add(request, withCompletionHandler: { (error: Error?) in
                if (error != nil) {
                    print("Something went wrong while schedualing the notification: \(error)");
                }
            })
        
        } else {
            // Fallback on earlier versions
            
            let n1 = UILocalNotification()
            n1.category = category
            //[NSDate dateWithTimeIntervalSinceNow: 60];
            n1.alertTitle = title
            n1.alertBody = messageBody
            n1.soundName = UILocalNotificationDefaultSoundName
            
            var userDict = userInfo
            userDict["uid"] = uid
            n1.userInfo = userDict
            n1.fireDate = fireDate
            
            if(isRepeating == true){
                n1.repeatInterval = .day;
            }
            
            UIApplication.shared.scheduleLocalNotification(n1);
            
            
        }
    }

    
    //    //create trigger1
    //    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:isRepeatingDaily];
    
    //create trigger2
    //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3600];

    
}
