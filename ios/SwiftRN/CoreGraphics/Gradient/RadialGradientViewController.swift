//
//  RadialGradientViewController.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/9/22.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class RadialGradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let v = RadialView()
//        v.colors = [UIColor.red,UIColor.green]
        v.frame = UIScreen.main.bounds
        view.addSubview(v)
        view.backgroundColor = UIColor.blue
        
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
