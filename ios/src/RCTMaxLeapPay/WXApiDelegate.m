//
//  WXApiDelegate.m
//  RCTMaxLeapPay
//
//  Created by Sun Jin on 5/11/16.
//  Copyright © 2016 maxleap. All rights reserved.
//

#import "WXApiDelegate.h"
#import "WXApiObject.h"
#import <MaxLeapPay/MaxLeapPay.h>

@implementation WXApiDelegate

+ (instancetype)sharedInstance {
    static WXApiDelegate *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [WXApiDelegate new];
    });
    return __sharedInstance;
}

- (void)onReq:(BaseReq *)req {
    
}

// response
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        [MaxLeapPay handleWXPayResponse:(PayResp *)resp];
    }
}

@end
