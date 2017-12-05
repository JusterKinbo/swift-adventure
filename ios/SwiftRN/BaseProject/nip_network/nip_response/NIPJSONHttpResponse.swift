//
//  NIPJSONHttpResponse.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/30.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation

class NIPJSONHttpResponse: NIPHttpResponse {
    var json:AnyObject
    public init(jsonObject:AnyObject)
    {
        json = jsonObject
        super.init(error: nil)
    }
    
}
