
//桥接头文件New2SwiftByCodes-Bridging-Header.h

//导入C类
#import "CClassWithHeader.h"
//导入OC类
#import "OCClass.h"
//声明没有头文件的C语言类中的函数
void desc1();
int sum1(int a, int b);

#import <CommonCrypto/CommonCrypto.h>
#import "nip_macros.h"


#import "DESEncryptor.h"

//第三方库 -- 直接在使用的地方导入即可

//定义宏
#define URL_FETCH_APPID @"http://reg.163.com/services/initMobApp"

