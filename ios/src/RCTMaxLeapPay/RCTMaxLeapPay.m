//
//  RCTMaxLeapPay.m
//  RCTMaxLeapPay
//

#import "RCTMaxLeapPay.h"
#import "MLPayment+RCTMaxLeapPay.h"
#import "WXApiDelegate.h"

@interface MaxLeapPay ()
+ (void)queryOrder:(NSDictionary *)params block:(MLArrayResultBlock)block;
@end

@implementation RCTMaxLeapPay

RCT_EXPORT_MODULE()

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOpenUrl:) name:@"RCTOpenURLNotification" object:nil];
    }
    return self;
}

- (void)handleOpenUrl:(NSNotification *)notification {
    NSURL *url = [NSURL URLWithString:notification.userInfo[@"url"]];
    [MaxLeapPay handleOpenUrl:url completion:^(MLPayResult * _Nonnull result) {
        
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

RCT_EXPORT_METHOD(setEnvironment:(MLPayEnvironment)environment) {
    [MaxLeapPay setEnvironment:environment];
}

RCT_EXPORT_METHOD(testChannelAvaliability:(NSString *)channelStr
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    MLPayChannel channel = MLPayChannelFromString(channelStr);
    BOOL flag = [MaxLeapPay isChannelAvaliable:channel];
    resolve(@(flag));
}

// 还未找到一个好的实践
// config {appId: "", description: ""}
RCT_EXPORT_METHOD(configWXPay:(NSDictionary *)config) {
    NSString *appId = config[@"appId"];
    NSString *description = config[@"description"];
    [MaxLeapPay setWXAppId:appId
                wxDelegate:[WXApiDelegate sharedInstance]
               description:description];
}

RCT_EXPORT_METHOD(startPayment:(NSDictionary *)payment
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    MLPayment *payement = [MLPayment fromDictionary:payment];
    [MaxLeapPay startPayment:payement completion:^(MLPayResult * _Nonnull result) {
        if (result.code == MLPaySuccess) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"channel"] = NSStringFromMLPayChannel(result.channel);
            if (result.infoDict) dict[@"info"] = result.infoDict;
            if (result.payment) dict[@"payment"] = [result.payment toDictionary];
            resolve(dict);
        } else {
            reject([@(result.code) stringValue],
                   result.error.localizedDescription,
                   result.error);
        }
    }];
}

// params: {channel: channelStr, billNum: billNo}, channel 可选
RCT_EXPORT_METHOD(findOrder:(NSDictionary *)params
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [MaxLeapPay queryOrder:params block:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            reject([@(error.code) stringValue],
                   error.localizedDescription,
                   error);
        } else {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:objects.count];
            [objects enumerateObjectsUsingBlock:^(MLOrder * _Nonnull order, NSUInteger idx, BOOL * _Nonnull stop) {
                [array addObject:order.infoDictionary];
            }];
            resolve(array);
        }
    }];
}

@end
