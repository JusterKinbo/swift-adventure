//
//  NIPSessionManager.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/31.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation
import Alamofire

enum NIPHttpRequestMethod
{
    case NIPHttpRequestMethodGet,NIPHttpRequestMethodPost,NIPHttpRequestMethodPut,NIPHttpRequestMethodDelete
}

class NIPHTTPSessionManager:SessionManager
{
    public static let sharedManager = NIPHTTPSessionManager()
    private init()
    {
        super.init()
    }
   
    public func requestWithPath(URLString:String,method1:NIPHttpRequestMethod,parameters:Parameters,constructingBody:(_ formData:MultipartFormData) -> (),success:@escaping (_ responseObject:Data) -> (),failure:@escaping ( _ error:Error) -> () ) -> DataRequest?
    {
        switch method1 {
        case .NIPHttpRequestMethodGet:
           return self.request(URLString, method:.get,parameters:parameters).responseJSON(){
                response in
                switch response.result
                {
                case .success(let _):
                    success(response.data!)
                        break
                case .failure(let err):
                    failure(err)
                    break
                }
            }
        
        case .NIPHttpRequestMethodPost:
            return nil
        case .NIPHttpRequestMethodPut:
            return nil
        case .NIPHttpRequestMethodDelete:
            return nil
        default:
            return nil

        }
    }
}
