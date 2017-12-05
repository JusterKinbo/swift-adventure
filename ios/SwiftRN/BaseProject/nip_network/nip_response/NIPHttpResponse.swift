//
//  NIPHttpResponse.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/30.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation

class NIPHttpResponse {
    var err:Error
    var urlResponse:HTTPURLResponse?
    public init(error:Error?)
    {
        err = error!
    }
   public convenience init()
   {
        self.init(error:nil)
    }
}
