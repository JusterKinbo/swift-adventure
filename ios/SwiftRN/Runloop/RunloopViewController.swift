//
//  RunloopViewController.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/9/13.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class RunloopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .green
        
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                print("main fire")//正常打印
            })
        }
        
//        DispatchQueue.global().async {
//            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
//                print("global fire")//无法打印
//            })
//            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
//        }
        DispatchQueue.global().async {
            // 非主线程不能使用 Timer.scheduledTimer进行初始化
            let timer = Timer(timeInterval: 1, repeats: true, block: { (timer) in
                print("fire")// 正常打印
            })
            
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        }
        
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
