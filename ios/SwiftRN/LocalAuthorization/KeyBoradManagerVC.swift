//
//  KeyBoradManagerVC.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/22.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class KeyBoradManagerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let detectBTN = UIButton(type:.system)
        detectBTN.frame = CGRect(x:30,y:100,width:200,height:30)
        detectBTN.setTitle("设备是否有第三方键盘", for: .normal)
        detectBTN.addTarget(self, action: #selector(detectHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(detectBTN)
        
        let setKeyboardEnableBTN = UIButton(type:.system)
        setKeyboardEnableBTN.frame = CGRect(x:30,y:150,width:200,height:30)
        setKeyboardEnableBTN.setTitle("设置第三方键盘的可用性", for: .normal)
        setKeyboardEnableBTN.addTarget(self, action: #selector(setKeyboardEnableHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(setKeyboardEnableBTN)
        
        let getKeyboardEnableBTN = UIButton(type:.system)
        getKeyboardEnableBTN.frame = CGRect(x:30,y:200,width:200,height:30)
        getKeyboardEnableBTN.setTitle("获取第三方键盘的可用性", for: .normal)
        getKeyboardEnableBTN.addTarget(self, action: #selector(getKeyboardEnableHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(getKeyboardEnableBTN)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func detectHandler(_ sender:UIButton)
    {
        var hasThirdKeyboard = false
        let activeInputModes = UITextInputMode.activeInputModes
        //无法进行isMemberOf class 检测，因为UIKeyboardExtensionInputMode这个类型是不存在的。。
        for inputMode in activeInputModes
        {
            print( String(describing: inputMode))
            if String(describing: inputMode).range(of: "UIKeyboardExtensionInputMode") != nil
            {
                hasThirdKeyboard = true
                break
            }
        }
        var alterMSG = "臣妾做不到啊"
        
        if hasThirdKeyboard
        {
            alterMSG="有第三方键盘"
        }else
        {
            alterMSG="没有第三方键盘"
        }
        
        let alertController = UIAlertController(title: "检测结果", message: alterMSG, preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        let alertView1 = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) -> Void in
            print("确定按钮点击事件")
        }
        alertController.addAction(alertView1)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func setKeyboardEnableHandler(_ sender:UIButton)
    {
        var enable = UserDefaults.standard.bool(forKey: "3rdKeyboardEnable")
        enable = !enable
        //判断UserDefaults中是否已经存在
        UserDefaults.standard.set(enable, forKey:"3rdKeyboardEnable")

        let alterMSG = "臣妾做不到啊,曲折策略只是简单的放在了UserDefaults但不到真正实时效果"
        let alertController = UIAlertController(title: enable ? "支持了":"取消了支持" , message: alterMSG, preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        let alertView1 = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) -> Void in
            print("确定按钮点击事件")
            }
        alertController.addAction(alertView1)
        self.present(alertController, animated: true, completion: nil)
        
        

    }
    @objc  func getKeyboardEnableHandler(_ sender:UIButton)
    {
        let enable = UserDefaults.standard.bool(forKey: "3rdKeyboardEnable")
        
        let alterMSG = ""
        let alertController = UIAlertController(title: enable ? "支持":"不支持" , message: alterMSG, preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        let alertView1 = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) -> Void in
            print("确定按钮点击事件")
        }
        alertController.addAction(alertView1)
        self.present(alertController, animated: true, completion: nil)
    }

   

}
