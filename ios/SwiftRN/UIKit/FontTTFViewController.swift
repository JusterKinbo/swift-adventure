//
//  FontTTFViewController.swift
//  SwiftRN
//
//  Created by bjjiachunhui on 2017/12/6.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class FontTTFViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let lable = UILabel()
        lable.font = UIFont.init(name: "iconfont", size: 20)
        lable.text = "\u{e6a2}"
        
        lable.frame = CGRect.init(x: 10, y: 100, width: 100, height: 30)
        self.view.addSubview(lable)
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
