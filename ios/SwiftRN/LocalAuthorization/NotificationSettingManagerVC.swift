//
//  NotificationSettingManagerVC.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/22.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationSettingManagerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        let detectBTN = UIButton(type:.system)
        detectBTN.frame = CGRect(x:30,y:100,width:200,height:30)
        detectBTN.setTitle("设备是否开启通知", for: .normal)
        detectBTN.addTarget(self, action: #selector(detectHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(detectBTN)
        
        let setKeyboardEnableBTN = UIButton(type:.system)
        setKeyboardEnableBTN.frame = CGRect(x:30,y:150,width:200,height:30)
        setKeyboardEnableBTN.setTitle("跳到设置", for: .normal)
        setKeyboardEnableBTN.addTarget(self, action: #selector(setNotificationEnableHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(setKeyboardEnableBTN)
        
        UNUserNotificationCenter.current().requestAuthorization(options: []) { (success, error) in
            if success
            {
                print("授权成功")
            }else
            {
                print("授权失败")
            }
        }
        
        let registerToSettingBundleBTN = UIButton(type:.system)
        registerToSettingBundleBTN.frame = CGRect(x:30,y:200,width:300,height:30)
        registerToSettingBundleBTN.setTitle("注册SettingBundle到UserDefaults", for: .normal)
        registerToSettingBundleBTN.addTarget(self, action: #selector(registerToSettingBundleHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(registerToSettingBundleBTN)
        
        
        let getSetttingBundleBTN = UIButton(type:.system)
        getSetttingBundleBTN.frame = CGRect(x:30,y:250,width:300,height:30)
        getSetttingBundleBTN.setTitle("获取UserDefaults中SettingBundle内容", for: .normal)
        getSetttingBundleBTN.addTarget(self, action: #selector(getSetttingBundleHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(getSetttingBundleBTN)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func detectHandler(_ sender:UIButton)
    {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (setting) in
            if setting.authorizationStatus == .authorized
            {
                print("授权了")
            }
            else
            {
                print("未授权")
            }
        }
        
    }
    
    @objc func setNotificationEnableHandler(_ sender:UIButton)
    {
        //首先你的app要有一个app setting，如果没有那么会crash
        
        //app setting:setting bundle 里面的东西可以通过UserDefalut.standard 来访问，通过其中的identifier即可访问
        let url = URL(string: UIApplicationOpenSettingsURLString)
        if UIApplication.shared.canOpenURL(url!)
        {
                UIApplication.shared.open(url!, options: [:], completionHandler:nil)
        }else
        {
            print("打不开")
        }
    }
    
    @objc func registerToSettingBundleHandler(_ sender:UIButton)
    {
       let settingBundle = Bundle.main.path(forResource: "Settings", ofType: "bundle")
        if settingBundle == nil
        {
            print("Could not find Settings.bundle");return
        }
        let sb = settingBundle! as NSString
        let setting = NSDictionary(contentsOfFile: sb.appendingPathComponent("Root.plist"))
        let prefs = setting?.object(forKey: "PreferenceSpecifiers") as! NSArray
        let dict2Regist = NSMutableDictionary(capacity : prefs.count)
        for pref in prefs
        {
            let dict = pref as! NSDictionary
            let key = dict.object(forKey: "Key")
            if (key != nil)
            {
                dict2Regist.setObject(dict.object(forKey: "DefaultValue")!, forKey: dict.object(forKey: "Key") as! NSString )
               
            }
            
        }
        UserDefaults.standard.register(defaults: dict2Regist as! [String : Any])
    }
    
    @objc func getSetttingBundleHandler(_ sender:UIButton)
    {
        let s = UserDefaults.standard.object(forKey: "account_prference") as! String
        print(s)
        
        
    }
    

}
