//
//  ViewController.swift
//  SwiftGitTest
//
//  Created by bjjiachunhui on 2017/12/18.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let l = UILabel.init(frame: CGRect.init(x: 10, y: 100, width: 100, height: 30   ))
        l.text = "我是卖报的"
        self.view.addSubview(l)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

