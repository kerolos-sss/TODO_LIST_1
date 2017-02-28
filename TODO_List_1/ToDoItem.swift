//
//  ToDoItem.swift
//  ClearStyle
//
//  Created by Audrey M Tam on 27/07/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    // A text description of this item.
    let uuid = NSUUID().uuidString

    var text: String?
    var time: Date?{
        willSet(newTime) {
            
            if(newTime == nil){
                
            }
            //print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            LocalNotificationUtil.deleteNotification(uid: uuid)
            
            if(time != nil){
                LocalNotificationUtil.scheduleNotification(uid: uuid, userInfo: Dictionary(), messageBody: "your remider for the time \(time)", title: "Test ", category: "", fireDate: time!, isRepeating: false)

            }
        }
    }
    // A Boolean value that determines the completed state of this item.
    var completed: Bool
    
    // Returns a ToDoItem initialized with the given text and default completed value.
    init(text: String?, time: Date?) {
        self.text = text
        self.completed = false
        self.time = time
    }   
}
