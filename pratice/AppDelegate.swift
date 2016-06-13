//
//  AppDelegate.swift
//  pratice
//
//  Created by bori－applepc on 15/10/12.
//  Copyright © 2015年 bori－applepc. All rights reserved.
//

import UIKit

class Cat {
    let defaultName: String = {
        print("Type constant initialized")
        return "ynotcc"
    }()
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let foo: Int = {
            print("global constant initialized")
            return 24
        }()
        print(foo)
        print(Cat().defaultName)
        
        

        
        if let userInfo = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] {
            print("Receive RemoteNotication, userInfo is \(userInfo)")
        }
        
        regisiterRemoteNotification()
        
        return true
    }
    
    func regisiterRemoteNotification() {
        let setting = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(setting)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        print("did register user notification settings")
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("Device Token:", tokenString)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
         print("Receive RemoteNotication, userInfo is \(userInfo)")
    }
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("error: \(error.localizedDescription)")
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
        for cmDownload in YnotDownloadManager.sharedInstance.downloadArray {
            if cmDownload.downloadState == DownloadState.Downloading {
                dPrint("name = \(cmDownload.identifier) url = \(cmDownload.url) existedData = \(cmDownload.existedData)")
            }
        }
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension NSObject {
    
    func dPrint(item: Any) {
        #if DEBUG
        print(item)
        #endif
    }
}


