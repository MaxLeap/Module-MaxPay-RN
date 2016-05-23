//
//  MLPayment+RCTMaxLeapPay.m
//  RCTMaxLeapPay
//
//  Created by Sun Jin on 5/9/16.
//  Copyright © 2016 maxleap. All rights reserved.
//

#import "MLPayment+RCTMaxLeapPay.h"

#define kChannelKey @"channel"
#define kTotalFeeKey @"totalFee"
#define kBillNoKey @"billNo"
#define kSubjectKey @"subject"
#define kExtraAttrsKey @"extraAttrs"
#define kSchemeKey @"scheme"
#define kReturnUrlKey @"returnUrl"

@implementation MLPayment (RCTMaxLeapPay)

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[kChannelKey] = NSStringFromMLPayChannel(self.channel);
    dict[kTotalFeeKey] = @(self.totalFee);
    if (self.billNo) dict[kBillNoKey] = self.billNo;
    if (self.subject) dict[kSubjectKey] = self.subject;
    if (self.extraAttrs) dict[kExtraAttrsKey] = self.extraAttrs;
    if (self.scheme) dict[kSchemeKey] = self.scheme;
    if (self.returnUrl) dict[kReturnUrlKey] = self.returnUrl;
    
    return dict;
}

+ (instancetype)fromDictionary:(NSDictionary *)dict {
    MLPayment *payment = [[MLPayment alloc] init];
    payment.channel = MLPayChannelFromString(dict[kChannelKey]);
    payment.totalFee = [dict[kTotalFeeKey] integerValue];
    payment.billNo = dict[kBillNoKey];
    payment.subject = dict[kSubjectKey];
    [payment.extraAttrs addEntriesFromDictionary:dict[kExtraAttrsKey]];
    payment.scheme = dict[kSchemeKey];
    payment.returnUrl = dict[kReturnUrlKey];
    return payment;
}

@end
