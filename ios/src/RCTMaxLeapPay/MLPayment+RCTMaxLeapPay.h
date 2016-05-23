//
//  MLPayment+RCTMaxLeapPay.h
//  RCTMaxLeapPay
//

#import <MaxLeapPay/MLPayment.h>

@interface MLPayment (RCTMaxLeapPay)

- (NSDictionary *)toDictionary;
+ (instancetype)fromDictionary:(NSDictionary *)dictionary;

@end
