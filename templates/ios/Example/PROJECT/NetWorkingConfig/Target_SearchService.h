//
//  Target_SearchService.h
//  ManJi
//
//  Created by manjiwang on 2019/1/5.
//  Copyright © 2019 Zgmanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Target_SearchService : NSObject

- (SearchService *)Action_SearchService:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
