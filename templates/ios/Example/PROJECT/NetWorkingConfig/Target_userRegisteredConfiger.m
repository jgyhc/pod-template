//
//  Target_userRegisteredConfiger.m
//  MJUserRegisteredKit_Example
//
//  Created by manjiwang on 2019/1/23.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import "Target_userRegisteredConfiger.h"

@implementation Target_userRegisteredConfiger

- (UIColor *)Action_themeColor:(NSDictionary *)params {
    return [UIColor colorWithRed:230/255.0 green:0/255.0 blue:18/255.0 alpha:1.0];
}

- (UIColor *)Action_noInteractionColor:(NSDictionary *)params {
    return [UIColor colorWithRed:245/255.0 green:153/255.0 blue:161/255.0 alpha:1.0];
}

- (NSString *)Action_deviceType:(NSDictionary *)params {
    return @"iPhone X";
}

- (NSString *)Action_area:(NSDictionary *)params {
    return @"500102";
}

- (NSNumber *)Action_longitude:(NSDictionary *)params {
    return @106.560162;
}

- (NSNumber *)Action_latitude:(NSDictionary *)params {
    return @29.578515;
}

- (NSUInteger)Action_passwordLength:(NSDictionary *)params {
    return 16;
}

- (NSString *)Action_currentAreaString:(NSDictionary *)params {
    return @"全国";
}



@end
