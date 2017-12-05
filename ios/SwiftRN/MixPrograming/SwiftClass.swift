//
//  SwiftClass.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/24.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit


class SwiftClass: NSObject {

   
    @objc(sayHello:)
    func sayHello(name:String) -> String {
        let greeting = "Hello" + name + "!"
       
        return greeting
    }
    
}
