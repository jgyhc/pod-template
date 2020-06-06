//
//  Target_userRegisteredConfiger.h
//  MJUserRegisteredKit_Example
//
//  Created by manjiwang on 2019/1/23.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_userRegisteredConfiger : NSObject

- (UIColor *)Action_themeColor:(NSDictionary *)params;

- (UIColor *)Action_noInteractionColor:(NSDictionary *)params;

- (NSString *)Action_deviceType:(NSDictionary *)params;

- (NSNumber *)Action_longitude:(NSDictionary *)params;

- (NSNumber *)Action_latitude:(NSDictionary *)params;

- (NSUInteger)Action_passwordLength:(NSDictionary *)params;

- (NSString *)Action_currentAreaString:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
