//
//  RNViewController.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/31.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit
import React



struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
class RNViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var jsCodeLocation:URL!
        
        if Platform.isSimulator {
            // Do one thing
            jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")
            print("模拟器")
        }
        else {
            print("真机")
            jsCodeLocation = URL(string: "http://10.235.2.8:8081/index.bundle?platform=ios")
        }
       
       
        let mockData:NSDictionary = ["scores":
            [
                ["name":"Alex", "value":"42"],
                ["name":"Joel", "value":"10"]
            ]
        ]
        
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "MyReactNativeApp",
            initialProperties: mockData as [NSObject : AnyObject],
            launchOptions: nil
        )
        self.view = rootView
        
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
