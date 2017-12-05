//
//  Native2RN.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/17.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation
import React

@objc(Native2RN)
class Native2RN:NSObject
{
    @objc func addEvent(_ name: String, location: String, date: NSNumber) -> Void {
        // Date is ready to use!
        print("addEvent******")
        NSLog("%@ %@ %@", name, location, date)
      
    }
    
    
    @objc func addEventWithCallback(_ name: String, location: String, date: NSNumber, callback: RCTResponseSenderBlock ) -> Void {
//        NSLog("%@ %@ %@", name, location, date)
        let ret:[String:Any] =  ["callback -> name": name, "location": location, "date" : date]
        callback([ret])
    }
    
    
  
   
}

