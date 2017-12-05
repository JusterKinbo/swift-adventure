//
//  RNGradinetView.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/17.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation
import UIKit
import React

@objc(RNGradientView)
class RNGradientView : UIView {
    
    var btn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let img = UIImageView()
        img.image = UIImage(named:"monkey")
        img.frame = CGRect(x:0,y:0,width:100,height:100)
        
        btn = UIButton(type:.system)
        btn.setTitle("原生btn", for: .normal)
        btn.frame = CGRect(x:20,y:20,width:50,height:50)
        btn.addTarget(self, action: #selector(btnClikced(id:)), for: UIControlEvents.touchUpInside)
        self.addSubview(img)
        self.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnClikced(id:UIButton)
    {
        print("clicked")
    }
    
    
    var enabled : Bool {
        set(newValue) {
            print("*** Setting isScanning to:", newValue)
            if newValue {
                btn.isEnabled = newValue
            }
        }
        get {
            return btn.isEnabled
        }
        
    }
    
}
