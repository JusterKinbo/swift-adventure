//
//  Native2RNEventEmitterBridge.m
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/17.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
@interface RCT_EXTERN_MODULE(Native2RNEventEmitter, NSObject)


RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)date callback: (RCTResponseSenderBlock)callback);

@end
