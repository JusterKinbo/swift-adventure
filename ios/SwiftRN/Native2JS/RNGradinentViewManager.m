//
//  RNGradinentViewManager.m
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/17.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>

#import <UIKit/UIkit.h>

#import "SwiftRN-Swift.h"

@interface RNGradinentViewManager: RCTViewManager

@end

@implementation RNGradinentViewManager
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (UIView *)view {
    return [[RNGradientView alloc]init];
}

RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL);

@end
