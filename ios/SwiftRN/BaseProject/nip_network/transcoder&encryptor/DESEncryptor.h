//
//  DESEncryptor.h
//  DESStudy
//
//  Created by longhuihu on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DESEncryptor : NSObject

+ (NSString *)generateStamp;
+ (NSData *)encyptPostData:(NSData *)data withStamp:(NSString*)stamp;
+ (NSData *)decryptPostData:(NSData*)encryptData withStamp:(NSString*)stamp;


@end

