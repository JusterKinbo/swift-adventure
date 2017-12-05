//
//  MixSwitWithOCVC.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/24.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class MixSwitWithOCVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let label = UILabel(frame:CGRect(x:30,y:100,width:100,height:30))
        label.text = "请看控制台"
        self.view.addSubview(label)
        // Do any additional setup after loading the view.
        let funOC = OCClass()
        funOC.desc2()
        funOC.desc22()
        funOC.saynomMSG("swift", andName: "666")
        let funOCClass2 = sum2(10, 1)
        print("swift调用OC类中的C函数输出:\(funOCClass2)")
        
        //swift调用c函数(无头文件)
        desc1()
        let funcCClassss = sum1(10, 2)
        print("swift调用没有头文件的C语言类输出:\(funcCClassss)")//12
        
        //swift调用c函数(有头文件)
        desc3()
        let funcCClass33 = sum3(10, 3)
        print("swift调用含有头文件的C语言类输出:\(funcCClass33)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
