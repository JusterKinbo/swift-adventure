//
//  UIButtonFactory.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/9.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class UIFactory1111 {
    private init()
    {
        
    }
    static private let factory = UIFactory()
    public class func  shared() -> UIFactory
    {
       return factory
    }
    
    
    //button
   public class func button(title:String) -> UIButton
    {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.setTitle(title, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    //lable
    public class func label(text:String) -> UILabel
    {
        let lab = UILabel()
        lab.text = text
        lab.layer.cornerRadius = 3
        lab.layer.masksToBounds = true
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }
    
    public class func multiLineLable(text:String) ->UILabel
    {
        let lab = UILabel()
        lab.text = text
        lab.lineBreakMode = .byWordWrapping
        lab.numberOfLines = 0 
        lab.layer.cornerRadius = 3
        lab.layer.masksToBounds = true
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }
    
}
