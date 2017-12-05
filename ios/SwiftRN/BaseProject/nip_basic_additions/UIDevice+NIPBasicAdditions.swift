//
//  UIDevice+NIPBasicAdditions.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/30.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import Foundation
import UIKit

/*
 * extension for Screen
 */
extension UIDevice
{
    public class func screenScale() -> CGFloat
    {
        return UIScreen.main.scale
    }

    public class func  screenWidth() -> CGFloat
    {
        return UIScreen.main.bounds.size.width
    }

    public class func screenHeight() -> CGFloat
    {
        return UIScreen.main.bounds.size.height
    }
    
    

   public class func fourInchScreen() -> Bool
   {
        return screenHeight() > 480
    }
}

/*
 * extension for System & Device Inf
 */
extension UIDevice
{
    /**
     *  @return 系统主版本号.
     */
    public class func systemMainVersion() -> Int
    {
        return (UIDevice.current.systemVersion as NSString).integerValue
    }

    /**
     *  @return 设备类别.
     */
    public class func deviceModel() -> String
    {
        var size:Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let platform = String(cString: machine)

        return platform
    }

    //! @return 处理器指令集类型，eg:x86_64
    public class func getProcessorInfo() -> String
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        var m = [CChar]()
        
        let mirror = Mirror(reflecting: systemInfo.machine)
        for (_, value) in mirror.children {
            switch value {
            case is Int8:
                m.append(CChar(value as! Int8))
            default: ()
            }
        }
        
        return String(cString: m, encoding: .utf8)!
    }

    //! @return 获取设备名称 eg:iPhone 6 (A1549/A1586)
    public class func getDeviceName() -> String
    {
        var mib = [Int32](repeating:0,count:2)
        var size = 0
        mib[0] = CTL_HW
        mib[1] = HW_MACHINE
        sysctl(&mib, 2, nil, &size, nil,0)
        var machine = [CChar](repeating: 0, count: size)
        sysctl(&mib, 2, &machine,&size, nil,0)
        let platform = String(cString: machine,encoding:.ascii)
        
        if platform == "iPhone1,1" { return "iPhone 2G (A1203)" }
        if platform == "iPhone1,2" { return "iPhone 3G (A1241/A1324)" }
        if platform == "iPhone2,1" {return  "iPhone 3GS (A1303/A1325)" }
        if platform == "iPhone3,1" { return "iPhone 4 (A1332)" }
        if platform == "iPhone3,2" { return "iPhone 4 (A1332)" }
        if platform == "iPhone3,3" { return "iPhone 4 (A1349)" }
        if platform == "iPhone4,1" { return "iPhone 4S (A1387/A1431)" }
        if platform == "iPhone5,1" { return "iPhone 5 (A1428)" }
        if platform == "iPhone5,2" { return "iPhone 5 (A1429/A1442)" }
        if platform == "iPhone5,3" { return "iPhone 5c (A1456/A1532)" }
        if platform == "iPhone5,4" { return "iPhone 5c (A1507/A1516/A1526/A1529)" }
        if platform == "iPhone6,1" { return "iPhone 5s (A1453/A1533)" }
        if platform == "iPhone6,2" { return "iPhone 5s (A1457/A1518/A1528/A1530)" }
        if platform == "iPhone7,1" { return "iPhone 6 Plus (A1522/A1524/A1593)"}
        if platform == "iPhone7,2" { return "iPhone 6 (A1549/A1586/A1589)" }
        if platform == "iPhone8,1" { return "iPhone 6S Plus (A1634/A1687/A1699)" }
        if platform == "iPhone8,2" { return "iPhone 6S (A1633/A1688/A1700)" }
        if platform == "iPhone8,4" { return "iPhone SE (A1723/A1662/A1724)" }
        if platform == "iPhone9,1" { return "iPhone 7（A1660/A1779/A1780)" }
        if platform == "iPhone9,2" { return "iPhone 7 Plus（A1661/A1785/A1786)"}
        
        if platform == "iPod1,1"   { return "iPod Touch 1 (A1213)" }
        if platform == "iPod2,1"   { return "iPod Touch 2 (A1288)" }
        if platform == "iPod3,1"   { return "iPod Touch 3 (A1318)" }
        if platform == "iPod4,1"   { return "iPod Touch 4 (A1367)" }
        if platform == "iPod5,1"   { return "iPod Touch 5 (A1421/A1509)" }
        if platform == "iPod7,1"   { return "iPod Touch 6 (A1574)" }
        
        if platform == "iPad1,1"   { return "iPad 1 (A1219/A1337)" }
        
        if platform == "iPad2,1"   { return "iPad 2 (A1395 Wi-Fi)" }
        if platform == "iPad2,2"   { return "iPad 2 (A1396 GSM)" }
        if platform == "iPad2,3"   { return "iPad 2 (A1397 CDMA)" }
        if platform == "iPad2,4"   { return "iPad 2 (A1395+New Chip Wi-Fi)" }
        if platform == "iPad2,5"   { return "iPad Mini 1 (A1432 Wi-Fi)" }
        if platform == "iPad2,6"   { return "iPad Mini 1 (A1454)" }
        if platform == "iPad2,7"   { return "iPad Mini 1 (A1455)" }
        
        if platform == "iPad3,1"   { return "iPad 3 (A1416 Wi-Fi)" }
        if platform == "iPad3,2"   { return "iPad 3 (A1403 Wi-Fi + LTE Verizon)" }
        if platform == "iPad3,3"   { return "iPad 3 (A1430 Wi-Fi + LTE AT＆T)" }
        if platform == "iPad3,4"   { return "iPad 4 (A1458 Wi-Fi)" }
        if platform == "iPad3,5"   { return "iPad 4 (A1459)" }
        if platform == "iPad3,6"   { return "iPad 4 (A1460)" }
        
        if platform == "iPad4,1"   { return "iPad Air (A1474 Wi-Fi)" }
        if platform == "iPad4,2"   { return "iPad Air (A1475 Wi-Fi + LTE)" }
        if platform == "iPad4,3"   { return "iPad Air (A1476 Rev)" }
        if platform == "iPad4,4"   { return "iPad Mini 2 (A1489 Wi-Fi)" }
        if platform == "iPad4,5"   { return "iPad Mini 2 (A1490 Wi-Fi + LTE)" }
        if platform == "iPad4,6"   { return "iPad Mini 2 (A1491)" }
        if platform == "iPad4,7"   { return "iPad Mini 3 (A1599 Wi-Fi)" }
        if platform == "iPad4,8"   { return "iPad Mini 3 (A1600)" }
        if platform == "iPad4,9"   { return "iPad Mini 3 (A1601)" }
        
        if platform == "iPad5,1"   { return "iPad Mini 4 (A1538 Wi-Fi)" }
        if platform == "iPad5,2"   { return "iPad Mini 4 (A1550 Wi-Fi + LTE)" }
        if platform == "iPad5,3"   { return "iPad Air 2 (A1566 Wi-Fi)" }
        if platform == "iPad5,4"   { return "iPad Air 2 (A1567 Wi-Fi + LTE)" }
        
        if platform == "iPad6,3"   { return "iPad Pro (A1673 9.7英寸 Wi-Fi)" }
        if platform == "iPad6,4"   { return "iPad Pro (A1674/A1675 9.7英寸 Wi-Fi + LTE)" }
        if platform == "iPad6,7"   { return "iPad Pro (A1584 12.9英寸 Wi-Fi)" }
        if platform == "iPad6,8"   { return "iPad Pro (A1652 12.9英寸 Wi-Fi + LTE)" }
        
        if platform == "i386"      { return "iPhone Simulator" }
        if platform == "x86_64"    { return "iPhone Simulator" }
        
        return platform!
    }
    
    

    /**
     *  @return 渠道名
     */
    public class func getChannelString() -> String
    {
        var cString:String?
        #if NETEASE_CHANNEL
        cString =  "tgwios";
        #else
        cString =  "appstore";
        #endif
        return cString!;
    }
}


