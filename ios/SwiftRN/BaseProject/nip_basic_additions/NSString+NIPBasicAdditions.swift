//
//  NSString+NIPBasicAdditions.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/20.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//


///未写完、未验证 - > 待完善
import Foundation

/**
 *  NSString NTBasicAdditions
 */

//Compare
public extension String
{
    /**
     *  比较字符串类型的版本大小，各数字的拆分用separate分离，例
     *  NSString *minVer = "3.0.0";NSString *maxVer = "5.0.1";
     *  NSString *currVer = "3.0";  currVer在区间[minVer,maxVer)内
     *  “1.0.0” == “1.0”，“1.0.0.0” < “1.0.2” ,“1.0.1”<“1.1” 等case成立
     *
     *  @param anotherString 比较的串
     *  @param separate      分隔符
     *
     *  @return 比较结果
     */
    public func compareNumericall(anotherString:String,seperator:String = ".") -> ComparisonResult
    {
        if (self.isEmpty && anotherString.isEmpty)
            { return .orderedSame }
        else if self.isEmpty
            { return .orderedAscending }
        else if anotherString.isEmpty
            { return .orderedDescending }
        
        let arr1 = self.utf8CString
        let arr2 = anotherString.utf8CString
        
        let len = arr1.count < arr2.count ? arr1.count : arr2.count
        for i in 0..<len
        {
            let res = arr1[i] - arr2[i]
            if res != 0
            {
                if res > 0
                    { return .orderedDescending }
                else
                    { return .orderedAscending }
            }
        }
        
        if arr1.count == arr2.count
        {
            return .orderedSame
        }else if len == arr1.count
        {
            for j in len..<arr2.count
            {
                if arr2[j] != 0
                { return .orderedAscending }
            }
            return .orderedSame
        }else
        {
            for j in len..<arr1.count
            {
                if arr1[j] != 0
                { return .orderedDescending }
            }
            return .orderedSame
        }
        
    }
    
    
}
//localization
public extension String
{
    public func localizedString(key:String) -> String
    {
        return Bundle.main.localizedInfoDictionary?[key] as! String
    }
}

//format inspect
public extension String
{
    /**
     *  若substring为空字符串或nil时, 返回值为YES.
     */
    public func contains(subString:String) -> Bool
    {
        if subString.isEmpty
        { return true }
        return self.contains(subString)
    }
    
    /**
     *  判断字符串中是否只包含空格和换行符.
     */
    public func isWhitespaceAndNewlines() -> Bool
    {
        let whitespace = CharacterSet.whitespacesAndNewlines
        for char in self.unicodeScalars
        {
            if whitespace.contains(char)
            { return false }
        }
        return true
    }
    /**
     *  判断字符串是否为空或只包含空格.
     */
    public func isEmptyOrWihteSpace() -> Bool
    {
        return self.isEmpty || self.isWhitespaceAndNewlines()
    }
    
    //! 判断emailAddr是否邮箱帐号
    public func isEmailAddress() -> Bool
    {
       let EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
       let regexTestMobile = NSPredicate(format: "SELF MATCHES %@",EMAIL)
       return regexTestMobile.evaluate(with:self)
    }
    //! 判断表达式expression是否整体符合正则表达式regex
    public func isMatch(regex:String) -> Bool
    {
        let regexTestMobile = NSPredicate(format: "SELF MATCHES %@",regex)
        return regexTestMobile.evaluate(with:self)
    }
    
    //! 判断mobileNum是否手机号
    public func isMobileNumber() -> Bool
    {
        let mobile = "^1[0-9]{10}$"
        return isMatch(regex: mobile)
    }
    
    //! 判断account是否有效的用户名。当前规则：用户名由字母、数字或“_”组成，以字母开头，长度不少于6位，不多于30位
    public func isAccountName() -> Bool
    {
        let account = "^[a-zA-Z][a-zA-Z0-9_]{5,29}$"
        return isMatch(regex: account)
    }
    
    //! 判断accountPwd是否有效的密码。当前规则：密码必须且只能包含字母，数字，下划线中的两种或两种以上,6-25位
    public func isAccountPwd() -> Bool
    {
        let account = "^(\\w*((?=\\w*\\d)(?=\\w*[a-zA-Z])|(?=\\w*\\d)(?=\\w*_)|(?=\\w*_)(?=\\w*[a-zA-Z]))\\w*)(\\w{6,25})$"
        return isMatch(regex: account)
    }
    
    //! 判断personName是否有效的密码。当前规则：姓名必须为中文或英文，中文两个字以上，英文3个字符以上
    public func isPersonName() -> Bool
    {
        let account = "^([\u{4e00}-\u{9fa5}]{2,5})|([a-zA-Z]+(?=[a-zA-Z\\s.]*[a-zA-Z]+)[a-zA-Z\\s.]{1,}[a-zA-Z.]{1,})$";
        return isMatch(regex: account)
    }
    
    //! 判断word是否汉字。
    public func isChineseWord() -> Bool
    {
        let account = "^([\u{4e00}-\u{9fa5}]+)$"
        return isMatch(regex: account)
    }
    
    //! 判断identityCard是否身份证。
    public func isIdentityCard() -> Bool
    {
        let identity = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
        
       if isMatch(regex: identity)
       {
            if self.characters.count == 18
            {
                let idCardWi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]//将前17位加权因子保存在数组里
                let idCardY = [1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                var idCardWiSum = 0 // 用来保存前17位各自乖以加权因子后的总和
                for i in 0..<17
                {
                   idCardWiSum += Int(self.utf8CString[i]) * idCardWi[i]
                }
                let idCardMod = idCardWiSum%11 //计算出校验码所在数组的位置
                let idCardLast = String(self[index(before: endIndex)])
                
                //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                if idCardMod == 2
                {
                    if idCardLast.compare("X",options:.caseInsensitive) == .orderedSame
                    {
                        return true
                    }else
                    {
                        return false
                    }
                }else
                {
                    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                    if idCardLast.compare(String(idCardY[idCardMod])) == .orderedSame
                    {
                        return true
                    }else
                    {
                        return false
                    }
                }
            }
        }
        return false
    }
    
    //! 通过身份证identityCard判断是否男性
   public func isMaleByIdentityCard() -> Bool
   {
        let male = Int(self.utf8CString[self.characters.count-2])
        return male % 2 == 0
    }
    
    //! 通过后缀判断fileName是否是图片名
    public func isImageFileName() -> Bool
    {
        let pngName = "^[\\s\\S]*.((bmp)|(dib)|(gif)|(jfif)|(jpe)|(jpeg)|(jpg)|(png)|(tif)|(tiff)|(ico))[\\s\\S]*$";
        return isMatch(regex: pngName)
    }
    
    //! 判断code是否是邮编。
    public func isPostalCode() ->Bool
    {
        let regex = "^[1-9]\\d{5}$";
        return isMatch(regex: regex)
    }
}


//Encode
let encodingTable =  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
public extension String
{
    /**
     Returns a percent-escaped string following RFC 3986 for a query string key or value.
     RFC 3986 states that the following characters are "reserved" characters.
     - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
     - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
     
     In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
     query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
     should be percent-escaped in the query string.
     - parameter string: The string to be percent-escaped.
     - returns: The percent-escaped string.
     */
    private func getNormalAllowedURLCharacterSet() -> CharacterSet
    {
        let kNTURLCharactersGeneralDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let kNTURLCharactersSubDelimitersToEncode = "!$&'()*+,;="
        var normalAllowedCharacterSet = CharacterSet.urlQueryAllowed
        normalAllowedCharacterSet.remove(charactersIn: kNTURLCharactersSubDelimitersToEncode+kNTURLCharactersGeneralDelimitersToEncode)
        return normalAllowedCharacterSet
    }
    
    /**
     *  对字符串进行url编码.
     */
    public func URLEncodedString() ->String
    {
        return URLEncodedString(allowedCharacterSet: getNormalAllowedURLCharacterSet())
    }
    /**
     *  对字符串进行url编码（剔除部分保留字符）
     *
     *  @param set 剔除的保留字符，即不对自定set内的字符进行percentescape
     *
     *  @return url编码过的字符串
     */
    public func URLEncodedStringLeaveUnescapedCharacterSet(set:CharacterSet) -> String
    {
        var allowSet = getNormalAllowedURLCharacterSet()
        allowSet.formUnion(set)
        return URLEncodedString(allowedCharacterSet:allowSet)
    }
    
    private func URLEncodedString(allowedCharacterSet:CharacterSet) ->String  {
    // 分批处理，字符串过长可能引起编码失败
    let batchSize = 50;
    var ind = startIndex;
    var encodedString = "";
    while ind < endIndex
    {
        var end = index(ind, offsetBy: batchSize)
        end = min(endIndex,end)
        var range = ind..<end
        range = self.rangeOfComposedCharacterSequences(for: range)
        let subString = String(self[range])
        let encoded = subString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        encodedString += encoded!
        ind = range.upperBound
    }
    return encodedString;
    }
    
    /**
     *  对字符串进行url解码.
     */
    public func URLDecodedString() ->String
    {
        return self.removingPercentEncoding!
    }
    
    /**
     *  对字符串进行html编码.
     */
    public func escapeHTML() ->String
    {
        var s = ""
        let chs = CharacterSet.init(charactersIn: "<>&\"")
        var startInd = startIndex
        let endInd = endIndex
        while startInd < endInd
        {
            let r = self.rangeOfCharacter(from: chs, options: .caseInsensitive, range: startInd..<endInd)
            guard r != nil else
            {
                s += String(self[startInd..<endInd])
                break
            }
            if startInd < (r?.lowerBound)!
            {
                s += String(self[startInd..<(r?.lowerBound)!])
            }
            switch(self.characters[(r?.lowerBound)!])
            {
            case "<":
                s += "&lt;"
                break;
            case ">":
                s += "&gt;"
                break;
            case "\"":
                s += "&quot;"
                break;
            case "&":
                s += "&amp;"
                break;
            default:
                //do nothing
                break
            }
            startInd = (r?.upperBound)!
        }
        return s
    }
    
    /**
     *  对字符串进行html解码.
     */
    public func unescapeHTML() -> String
    {
        var s = ""
        let chs = CharacterSet.init(charactersIn: "&")
        var target = self
        var startInd = startIndex
        let endInd = endIndex
        while startInd < endInd
        {
            let r = target.rangeOfCharacter(from: chs)
            guard r != nil else
            {
                s += String(self[startInd..<endInd])
                break
            }
            if let ind = r?.lowerBound
            {
                s += String(self[startInd..<ind])
                startInd = ind
                target = String(target[ind..<endInd])
            }
           if target.hasPrefix("&lt;")
           {
                s += "<"
                startInd = index(startInd, offsetBy: 4)
                target = String(target[startInd..<endInd])
            }else if target.hasPrefix("&gt;")
           {
                s += ">"
                startInd = index(startInd, offsetBy: 4)
                target = String(target[startInd..<endInd])
            }else if target.hasPrefix("&quot;")
           {
                s += "\""
                startInd = index(startInd, offsetBy: 4)
                target = String(target[startInd..<endInd])
            }else if target.hasPrefix("&amp;")
           {
                s += "&"
                startInd = index(startInd, offsetBy: 4)
                target = String(target[startInd..<endInd])
            }else
           {
                s += "&"
                startInd = index(startInd, offsetBy: 1)
                target = String(target[startInd..<endInd])
            }
        }
        
        
        return s
    }
    
    private func stringByAppendingUrlParameters(params:Dictionary<String, String>) -> String
    {
        guard !params.isEmpty else
        {
            return self
        }
        
        var string = self
        let keys = params.keys.sorted()
        
        if let _ = string.range(of: "=")
        {
           string = string.appendingFormat("&%@=%@", keys[0],params[keys[0]]!)
        }else
        {
            string = string.appendingFormat("?%@=%@", keys[0],params[keys[0]]!)
        }
        
        for i in 1 ..< keys.count
        {
            let key = keys[i]
            let val = params[key]!
            string = string.appendingFormat("&%@=%@", keys,val)
        }
        
        return string
    }
    
    private func breakQueryParameters() -> Dictionary<String,String>
    {
        let arr = self.components(separatedBy:"&")
        var params = Dictionary<String,String>()
        for ele in arr
        {
            let pair = ele.components(separatedBy: "=")
            if pair.count == 2
            {
                params[pair[0]] = params[pair[1]]
            }
        }
        return  params
    }
    
    private func getQueryParameters() -> Dictionary<String,String>
    {
        var str = self
        if let r = self.range(of: "?", options: .backwards)
        {
            str = String(self[r.lowerBound..<endIndex])
        }
        return str.breakQueryParameters()
        
    }
    

    public func md5Digest() -> String
    {
        let chars = self.components(separatedBy: "")
        let results:[UInt8] = Array.init(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        let result = UnsafeMutablePointer(mutating: results)
        CC_MD5(UnsafeRawPointer(chars),(CC_LONG)(chars.count),result)
        var returnHashSum = ""
        for i in 0 ..< CC_MD5_DIGEST_LENGTH
        {
            returnHashSum = returnHashSum.appendingFormat("%02x", result[Int(i)])
        }
        return returnHashSum
    }

    public func base64Encode() -> String!
    {
        guard !self.isEmpty else
        {
            return self
        }
        let source = self.utf8CString
        let strLen = source.count
        
        var characters = malloc(((strLen + 2) / 3) * 4)
        let resultCharacters = characters
        let encodingTB = encodingTable.utf8CString
        
        var length = 0
        var i = 0
        while i < strLen
        {
            var buffer = [0,0,0]
            var bufferLength = 0
            while bufferLength < 3 && i < strLen
            {
               
                buffer[bufferLength] = Int(source[i])
                bufferLength += 1
                i += 1
            }
            
           characters?.storeBytes(of: encodingTB[(buffer[0] & 0xFC) >> 2], as: CChar.self)
            length += 1
            characters? += 1
            characters?.storeBytes(of: encodingTB[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)], as: CChar.self)
            length += 1
            characters? += 1
            if bufferLength > 1
            {
                characters?.storeBytes(of: encodingTB[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)], as: CChar.self)
                length += 1
                characters? += 1
            }else
            {
                characters?.storeBytes(of: "=".utf8CString[0], as: CChar.self)
                length += 1
                characters? += 1
            }
            if bufferLength > 2
            {
                characters?.storeBytes(of: encodingTB[buffer[2] & 0x3F], as: CChar.self)
                length += 1
                characters? += 1
            }else
            {
                characters?.storeBytes(of: "=".utf8CString[0], as: CChar.self)
                length += 1
                characters? += 1
            }
        }
        return String.init(bytesNoCopy: resultCharacters!, length: length, encoding:.ascii , freeWhenDone: true)
    }

    public func base64Decode() -> String!
    {
        var ixtext = 0
        let lentext = self.characters.count
        var ch:CChar
        var inbuf:[UInt8] = [0,0,0,0]
        var outbuf:[UInt8] = [0,0,0,0]
        var ixinbuf = 0
        var flignore = false
        var flendtext = false
        let tempcstring = self.utf8CString
        var theData = Data.init(count: lentext)
        
        while true
        {
            if ixtext >= lentext
            {
                break
            }
            ch = tempcstring[ixtext]; ixtext += 1
            flignore = false
            if ((ch >= "A".utf8CString[0]) && (ch <= "Z".utf8CString[0]))
            {
                ch = ch - "A".utf8CString[0]
            }else if ((ch >= "a".utf8CString[0]) && (ch <= "z".utf8CString[0]))
            {
                 ch = ch - "a".utf8CString[0]
            }else if ((ch >= "0".utf8CString[0]) && (ch <= "9".utf8CString[0]))
            {
                ch = ch - "0".utf8CString[0] + 52
            }else if (ch == "+".utf8CString[0])
            {
                ch = 62
            }else if (ch == "=".utf8CString[0])
            {
                flendtext = true
            }else if (ch == "/".utf8CString[0])
            {
                ch = 63
            }else
            {
                flignore = true
            }
            
            if(!flignore)
            {
                var ctcharsinbuf = 3
                var flbreak = false
                
                if (flendtext)
                {
                    if ixinbuf == 0
                    {
                        break
                    }
                    
                    if (ixinbuf == 1 || ixinbuf == 2)
                    {
                        ctcharsinbuf = 1
                    }else
                    {
                        ctcharsinbuf = 2
                    }
                    
                    ixinbuf = 3
                    flbreak = true
                }
                
                inbuf[ixinbuf] = UInt8(ch) ; ixinbuf += 1
                
                if ixinbuf == 4
                {
                    ixinbuf = 0
                    
                    outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                    outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                    outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                    
                    for i in 0 ..< ctcharsinbuf
                    {
                        let count = 1
                        let bytesPointer = UnsafeMutableRawPointer.allocate(
                            bytes: count * MemoryLayout<UInt8>.stride,
                            alignedTo: MemoryLayout<UInt8>.alignment)
                        let int8Pointer = bytesPointer.initializeMemory(as: UInt8.self,  count: count, to: outbuf[i])
                        theData.append(bytesPointer.assumingMemoryBound(to: UInt8.self), count: 1)
                        // After using 'int8Pointer':
                        theData.append(Array.init(repeating:outbuf[i],count:1), count: 1)
                        
                        int8Pointer.deallocate(capacity: count)
                        
                    }
                }
                
                if flbreak
                {
                    break
                }
            }
            
        }
        
        return String.init(data: theData, encoding: .utf8)
    }
    

    public func base16Data() -> Data?
    {
        let count = self.characters.count
        guard count % 2 == 0 else {return nil}
        var keys:[UInt8] = Array.init(repeating: 0, count: count/2)
        for i in 0 ..< (count/2)
        {
            let ind = index(startIndex, offsetBy: 2*i)
            let end = index(ind, offsetBy: 2)
            let str = self[ind..<end]
            keys[i] = stringToASCIIChar(str: String(str))
        }
        return Data.init(bytes: keys)
    }
    
    private func isValidHttpURL() -> Bool
    {
        return self.hasPrefix("http")
    }
    
    private func stringMatchRegex(regex:String) -> String?
    {
        let reg = try? NSRegularExpression.init(pattern: regex, options: .caseInsensitive)
        guard reg != nil else { return nil }
        
        let range  = reg!.rangeOfFirstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRangeFromString(self))
        if range.length > 0
        {
            let start = index(startIndex, offsetBy: range.location)
            let end = index(start, offsetBy: range.length)
            return String(self[start ..< end])
        }
            return nil
    }
    
    private func stringToASCIIChar(str:String) -> UInt8
    {
        guard str.count > 2 else
        {
            return 0
        }
        let str: String = "abc1个"
        // String转换为CChar数组
        let charArray: [CChar] = str.cString(using: String.Encoding.utf8)!
        let m = str.utf8CString
        
        let s = "Hello!"
        let bytes = s.utf8CString
        print(bytes)
        // Prints "[72, 101, 108, 108, 111, 33, 0]"
        
        bytes.withUnsafeBufferPointer { ptr in
            print(strlen(ptr.baseAddress!))
        }
        return 0
    }
//
//    /**
//     *  对字符串进行JavaScript编码.
//    - (NSString *)javaScriptEscape;
//
//    /**
//     *  对字符串进行JavaScript解码.
//     */
//    - (NSString *)javaScriptUnescape;
//
//    /**
//     *  获取字符串的utf8编码字符串
//     *
//     *  @return 编码字符串
//     */
//    - (NSString *)encodeUTF8;
//
//    /**
//     *  获取字符串的gb2312字符串
//     *
//     *  @return 编码字符串
//     */
//    - (NSString *)encodeGB2312;
//
//    /**
//     *  判断字符串中是否有gb2312编码中不包含的生僻字
//     *
//     *  @return 是否有生僻字
//     */
//    - (BOOL)containRarelyUsedWordByEncodeGB2312;
}
//URL String
public extension String
{

}
//Extract Content With Rule
public extension String
{

}
// subscript
public extension String {

//    subscript (i: Int) -> CChar {
//        return self.utf8CString[i]
//    }



    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

