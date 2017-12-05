//
//  NIPCoderUtil.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/30.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation



class NIPCoderUtil {

    /**
     *  @param defaulValue 若key对应值为空, 则返回此默认值.
     *
     *  @return 返回key对应值的bool值, 如果值为nil或NSNull, 返回defaultValue.
     */
    public class func boolFrom(dict:Dictionary<String, Any>, key:String, defaultValue:Bool) -> Bool
    {
        if let obj = dict[key]
        {
            if  (obj as! NSObject).responds(to: #selector(getter: NSNumber.boolValue))
               {
                return (obj as AnyObject).boolValue
                }
        }
        return defaultValue
    }
    
    /**
     *  @param defaulValue 若key对应值为空, 则返回此默认值.
     *
     *  @return 返回key对应值的integer值, 如果值为nil或NSNull, 返回defaultValue.
     */
    public class func integerFrom(dict:Dictionary<String,Any>,key:String,defaultValue:Int) -> Int
    {
        if let obj = dict[key]
        {
            if  (obj as! NSObject).responds(to: #selector(getter: NSNumber.intValue))
            {
                return (obj as AnyObject).intValue
            }
        }
        return defaultValue
    }

    /**
     *  @param defaulValue 若key对应值为空, 则返回此默认值.
     *
     *  @return 返回key对应值的uinteger值, 如果值为nil或NSNull, 返回defaultValue.
     */
    public class func uintegerFrom(dict:Dictionary<String,Any>,key:String,defaultValue:UInt) -> UInt
    {
        if let obj = dict[key]
        {
            if  (obj as! NSObject).responds(to: #selector(getter: NSNumber.uintValue))
            {
                return (obj as AnyObject).uintValue
            }
        }
        return defaultValue
    }

    /**
     *  @param defaulValue 若key对应值为空, 则返回此默认值.
     *
     *  @return 返回key对应值的long值, 如果值为nil或NSNull, 返回defaultValue.
     */
    public class func longFrom(dict:Dictionary<String,Any>,key:String,defaultValue:CLongLong) -> CLongLong
    {
        if let obj = dict[key]
        {
            if  (obj as! NSObject).responds(to: #selector(getter: NSString.longLongValue))
            {
                return (obj as AnyObject).longLongValue
            }
        }
        return defaultValue
    }

    /**
     *  @param defaulValue 若key对应值为空, 则返回此默认值.
     *
     *  @return 返回key对应值的double值, 如果值为nil或NSNull, 返回defaultValue.
     */
    public class func doubleFrom(dict:Dictionary<String,Any>,key:String,defaultValue:Double) -> Double
    {
        if let obj = dict[key]
        {
            if  (obj as! NSObject).responds(to: #selector(getter: NSNumber.doubleValue))
            {
                return (obj as AnyObject).doubleValue
            }
        }
        return defaultValue
    }


    /**
     *  @param defaulValue 若key对应值为空, 则返回此默认值.
     *
     *  @return 返回key对应值的float值, 如果值为nil或NSNull, 返回defaultValue.
     */
    public class func floatFrom(dict:Dictionary<String,Any>,key:String,defaultValue:Float) -> Float
    {
        if let obj = dict[key]
        {
            if  (obj as! NSObject).responds(to: #selector(getter: NSNumber.floatValue))
            {
                return (obj as AnyObject).floatValue
            }
        }
        return defaultValue
    }

    /**
     *  @return 返回key对应值的字符串形式, 若值为nil或NSNull, 返回空字符串.
     */
    public class func stringFrom(dict:Dictionary<String,Any>,key:String,defaultValue:String) -> String
    {
        if let obj = dict[key]
        {
            if  (obj is String)
            {
                return obj as! String
            }
        }
        return defaultValue
    }
}
