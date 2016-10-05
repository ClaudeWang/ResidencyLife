//
//  AppDelegate.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 8/29/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var client: MSClient?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.client = MSClient(
            applicationURLString:"https://residencylife.azurewebsites.net"
        )
        //adding the mutable notification setting.
        let reminderActionSnooze = UIMutableUserNotificationAction()
        reminderActionSnooze.identifier = "Snooze"
        reminderActionSnooze.title = "Snooze"
        reminderActionSnooze.activationMode = UIUserNotificationActivationMode.Background
        reminderActionSnooze.destructive = true
        reminderActionSnooze.authenticationRequired = false
        
        let reminderCategory = UIMutableUserNotificationCategory()
        reminderCategory.identifier = "reminderCategory"
        reminderCategory.setActions([reminderActionSnooze], forContext: UIUserNotificationActionContext.Default)
        //register the notification.
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: Set(arrayLiteral: reminderCategory)))
        
        
        
        let notification = UILocalNotification()
        notification.alertTitle = "Burnout Survey"
        notification.alertBody = "It's time for some surveys!"
        notification.alertAction = "open"
        notification.category = "reminderCategory"
        notification.soundName = UILocalNotificationDefaultSoundName
        

        
        //schedule the second notification, this is a work-around.
        //schedule a notification that pops up every week, with four days a week.
        
        let scheduleYear = 2016
        let scheduleMonth = 09
        let fixedHour = 19
        let fixedMinute = 30
        let fixedTimeZone = NSTimeZone.defaultTimeZone()
        
        //schedule the notification on Monday
        let dateComponentsMon = NSDateComponents()
        dateComponentsMon.year = scheduleYear
        dateComponentsMon.month = scheduleMonth
        dateComponentsMon.day = 19
        dateComponentsMon.hour = fixedHour
        dateComponentsMon.minute = fixedMinute
        dateComponentsMon.timeZone = fixedTimeZone;
        //schedule the notification on wednesday
        let dateComponentsWed = NSDateComponents()
        dateComponentsWed.year = scheduleYear
        dateComponentsWed.month = scheduleMonth
        dateComponentsWed.day = 21
        dateComponentsWed.hour = fixedHour;
        dateComponentsWed.minute = fixedMinute;
        dateComponentsWed.timeZone = fixedTimeZone;
        //schedule the notification on Friday
        let dateComponentsFri = NSDateComponents()
        dateComponentsFri.year = scheduleYear
        dateComponentsFri.month = scheduleMonth
        dateComponentsFri.day = 23
        dateComponentsFri.hour = fixedHour;
        dateComponentsFri.minute = fixedMinute;
        dateComponentsFri.timeZone = fixedTimeZone;
        //schedule the notification on Sunday
        let dateComponentsSun = NSDateComponents()
        dateComponentsSun.year = scheduleYear
        dateComponentsSun.month = scheduleMonth
        dateComponentsSun.day = 25
        dateComponentsSun.hour = fixedHour;
        dateComponentsSun.minute = fixedMinute;
        dateComponentsSun.timeZone = fixedTimeZone;
        
        
        notification.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsMon)
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        notification.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsWed)
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        notification.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsFri)
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        notification.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsSun)
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        if (identifier == "Snooze") {
            notification.fireDate = NSDate().dateByAddingTimeInterval(60 * 20)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }


}

