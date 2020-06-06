//
//  Target_CustomerService.h
//  ManJi
//
//  Created by manjiwang on 2019/1/5.
//  Copyright © 2019 Zgmanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Target_CustomerService : NSObject
- (CustomerService *)Action_CustomerService:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
