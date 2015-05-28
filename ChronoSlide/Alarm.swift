//
//  Alarm.swift
//  ChronoSlide
//
//  Created by Tim Harris on 10/1/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

import Foundation
import UIKit

class Alarms: NSObject {
    var alarmNotification: UILocalNotification
    var alarmDate: NSDate?
    var activeState:Bool
    
    override var description:String{
        return self.timeString()
    }
    
    func timeString()->String{
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        return dateFormatter.stringFromDate(self.alarmDate!)
    }
    
    // alarm sound
    override init() {
        self.alarmNotification = UILocalNotification()
        self.alarmDate = nil
        self.activeState = false
    }
    
    
}