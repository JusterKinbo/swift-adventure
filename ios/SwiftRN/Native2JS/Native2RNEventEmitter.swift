//
//  Native2RNEventEmitter.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/17.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation
import React //一定要导入react

@objc(Native2RNEventEmitter)
class Native2RNEventEmitter: RCTEventEmitter {
    
    @objc override func supportedEvents() -> [String]! {
        return ["EventReminder"];
    }
    
    @objc func addEvent(_ name: String, location: String, date: NSNumber, callback: RCTResponseSenderBlock ) -> Void {
        // Date is ready to use!
        NSLog("%@ %@ %@", name, location, date)
        let ret:[String:Any] =  ["name": name, "location": location, "date" : date]
        callback([ret])
        self.sendEvent(withName: "EventReminder", body: ret)
    }
    
    @objc override func constantsToExport() -> [String : Any]! {
        return [
            "x": 1,
            "y": 2,
            "z": "Arbitrary string"
        ]
    }
    
    
}
