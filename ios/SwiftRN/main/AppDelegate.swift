//
//  AppDelegate.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/9.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var vc : UIViewController?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUGXXX
            print("debug xxxx")
        #else
            print("no debug xxxx")
        #endif
        
        
        /**
         注册通知
         iOS 10
         */
        // 请求用户授权
        let cur = UNUserNotificationCenter.current()
        cur.requestAuthorization(options: [UNAuthorizationOptions.alert,UNAuthorizationOptions.badge,UNAuthorizationOptions.sound])
        { (granted, error) in
                print("授权。。。。")
        }
        cur.getNotificationSettings { (setting) in
            print("授权状态：=》",setting)
        }
        cur.delegate = self//iOS 以后需要显示只能才能保证appDelegate成为通知的代理
        
        
        let rootV=ViewController()
        vc = rootV
        let nav=UINavigationController(rootViewController:rootV);
        // 创建窗口
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController=nav;
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}


//通知代理===不在像OC里面使用#pragam mark 通知代理区分

extension AppDelegate:UNUserNotificationCenterDelegate
{
    //远程通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
    
    //将要收到通知的时候，提示是否需要呈现通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.badge,UNNotificationPresentationOptions.sound])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //iOS 不在建议从launchOptioin里面取数据，而是从这里响应通知点击进入app
        //此处可以通过点击通知跳转到指定页面
//        (window?.rootViewController as! UINavigationController).pushViewController(BaseProjectViewController(), animated: true);
        
        //针对点击了3Dtouch的aciton进行操作，与通用的区别可以设定不同的identifer
        let identifier = response.notification.request.content.categoryIdentifier
        if identifier == "message"
        {
            if response.actionIdentifier == "input text"
            {
                let res = response as! UNTextInputNotificationResponse
                let text = res.userText
                print("notificaiton input text:  ",text)
                
            }
        }
        completionHandler()
    }
}



