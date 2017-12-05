//
//  NIPModelHttpResponse.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/30.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation

class NIPModelHttpResponse: NIPJSONHttpResponse {
    var model:AnyObject
    
    init(modelObject:AnyObject) {
        model = modelObject
        super.init(jsonObject: "测试" as AnyObject)
    }
    
}
