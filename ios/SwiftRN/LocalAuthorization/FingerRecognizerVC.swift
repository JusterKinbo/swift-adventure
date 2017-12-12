//
//  FingerRecognizerVC.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/21.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit
import LocalAuthentication

typealias replyCallBack = (_ args:Array<Any>) -> ()

enum NIPFingerRecognizerMode {
    case NIPFingerRecognizerModeWithBiometricsLocakedOutdUsePasscode
    case NIPFingerRecognizerModeWithBiometricsAndPasscode
    case NIPFingerRecognizerModeWithBiometricsOnly
}


class FingerRecognizerVC: UIViewController {
    var labelBiometricType:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = .white
        
        
        let label = UILabel()
        label.frame =  CGRect(x:30,y:100,width:200,height:26)
        label.text = "点击图片进行指纹识别"
        self.view.addSubview(label)
        
        let iv = UIImageView()
        iv.frame = CGRect(x:100,y:150,width:135,height:135)
        iv.image = UIImage(named:"fingerPrint")
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector(FingerRecognizerVC.tapHandler(_:)))
        iv.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(iv)
        
        let btn = UIButton(type:.system)
        btn.setTitle("支持指纹与否", for: .normal)
        btn.frame = CGRect(x:30,y:400,width:200,height:30)
        btn.addTarget(self, action: #selector(FingerRecognizerVC.btnHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(btn)
        
        
        //生物识别类型
        let btnBiometricType = UIButton(type:.system)
        btnBiometricType.setTitle("生物识别类型类型", for: .normal)
        btnBiometricType.frame = CGRect(x:30,y:450,width:200,height:30)
        btnBiometricType.addTarget(self, action: #selector(FingerRecognizerVC.btnBiometricsHandler(_ :)), for: .touchUpInside)
        self.view.addSubview(btnBiometricType)
        
        labelBiometricType = UILabel()
        labelBiometricType.frame =  CGRect(x:250,y:450,width:200,height:30)
        labelBiometricType.text = "待显示"
        self.view.addSubview(labelBiometricType)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func tapHandler(_ g:UITapGestureRecognizer)
    {
        print("开始指纹识别")
        self.fingerRecognizer(mode: .NIPFingerRecognizerModeWithBiometricsOnly, reason: "需要验证指纹", localizedCancelTitle: "", localizedFallbackTitle: "") { (arr) in
            print("识别结果:" + (arr[2] as! String))
            print("识别码：\((arr[1] as! Int))")
            print("设备支持码：\((arr[0] as! Int))" )
        }
    }
    @objc func btnHandler(_ btn:UIButton){
         print("开始检测当前机型是否支持指纹识别")
        var alterMSG = "不支持"
        if self.canDeviceSupportFingerRecognizer() == true
        {
            alterMSG = "支持"
        }
        let alertController = UIAlertController(title: "支持与否", message: alterMSG, preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        
        let alertView1 = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) -> Void in
            
            print("确定按钮点击事件")
            
        }
        
      
        alertController.addAction(alertView1)
        
        // 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func btnBiometricsHandler(_ btn:UIButton){
        print("开始检测当前机型是否支持生物识别")
        let type = biometricsTypeSupportedBuyDevice()
        switch type {
        case .none:
        labelBiometricType.text = "不支持"
            break
        case .touch:
            labelBiometricType.text = "支持touch id"
            break
        case .face:
            labelBiometricType.text = "支持face id"
            break
        }
    }
    
/*指纹识别需要导入LocalAthorization框架并在使用的地方再import一下头文件*/
    
func canDeviceSupportFingerRecognizer() -> Bool
{
   
    let context = LAContext()
    var error : NSError?
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
}

enum BiometricType {
    case none
    case touch
    case face
}
func biometricsTypeSupportedBuyDevice() -> BiometricType
{
    let context = LAContext()
    if #available(iOS 11, *) {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch(context.biometryType) {
        case .none:
            return .none
        case .touchID:
            return .touch
        case .faceID:
            return .face
        }
    } else {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
    }
    
}
    
func fingerRecognizer(mode:NIPFingerRecognizerMode, reason:String, localizedCancelTitle:String,localizedFallbackTitle:String,reply:@escaping replyCallBack)
{
    switch mode {
    case .NIPFingerRecognizerModeWithBiometricsOnly:
        self.fingerRecognizer(canEvalutePolicy: .deviceOwnerAuthenticationWithBiometrics, evalutePolicy: .deviceOwnerAuthenticationWithBiometrics, reason: reason, localizedCancelTitle: localizedCancelTitle, localizedFallbackTitle: localizedFallbackTitle, reply: reply, failedUsePasscode: false)
        break
    case .NIPFingerRecognizerModeWithBiometricsAndPasscode:
        self.fingerRecognizer(canEvalutePolicy: .deviceOwnerAuthentication, evalutePolicy: .deviceOwnerAuthentication, reason: reason, localizedCancelTitle: localizedCancelTitle, localizedFallbackTitle: localizedFallbackTitle, reply: reply, failedUsePasscode: false)
        break
    case .NIPFingerRecognizerModeWithBiometricsLocakedOutdUsePasscode:
        self.fingerRecognizer(canEvalutePolicy: .deviceOwnerAuthenticationWithBiometrics, evalutePolicy: .deviceOwnerAuthenticationWithBiometrics, reason: reason, localizedCancelTitle: localizedCancelTitle, localizedFallbackTitle: localizedFallbackTitle, reply: reply, failedUsePasscode: true)
        break
    }
}

func fingerRecognizer(canEvalutePolicy:LAPolicy,evalutePolicy:LAPolicy,reason:String,localizedCancelTitle:String,localizedFallbackTitle:String,reply:@escaping replyCallBack,failedUsePasscode:Bool)
{
    //str 2 flot
    //let v = UIDevice.current.systemVersion._bridgeToObjectiveC().floatValue
    let v = (UIDevice.current.systemVersion as NSString).floatValue
    let context = LAContext()
    context.localizedFallbackTitle = localizedFallbackTitle
    context.localizedCancelTitle = localizedCancelTitle
    var error: NSError?
    //先检测设备是否支持
    if context.canEvaluatePolicy(canEvalutePolicy, error: &error)
    {
            context.evaluatePolicy(evalutePolicy, localizedReason: reason, reply: { (success, error) in
                if success
                {
                    reply([1,0,"vertify success"])
                }
                else
                {
                    let e = error! as NSError
                    reply([1,e.code,"\(String(describing: error!.localizedDescription))"])
                }
            })
        
    }
    else
    {   //此时是版本9.0及以上支持passcode
       
        if v >= 9.0 && error!.code == LAError.touchIDLockout.rawValue
        {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: { (success, error) in
               
                if success
                {
                    self.fingerRecognizer(canEvalutePolicy: canEvalutePolicy, evalutePolicy: evalutePolicy, reason: reason, localizedCancelTitle: localizedCancelTitle, localizedFallbackTitle: localizedFallbackTitle, reply: reply,  failedUsePasscode: true)
                }else
                {
                    let e = error! as NSError
                    reply([1,e.code,"\(String(describing: error!.localizedDescription))"])
                }
                
            })
        }else
        {
             reply([0,error!.code,"\(String(describing: error!.localizedDescription))"])
            
        }
    }
    
    
}

}
