//
//  SearchService.m
//  ManJi
//
//  Created by manjiwang on 2018/5/21.
//  Copyright © 2018年 Zgmanhui. All rights reserved.
//

#import "SearchService.h"
//#import "InterfaceConfiguration.h"
//#import "Hardwaremodel.h"
//#import "MJUserInstance.h"


@implementation SearchService

- (NSString *)apiBaseUrl {
    return @"http://zuul.manjiwangtest.com";
//    return @"http://zuul.manjiwang.com";
}

- (NSString *)apiGatewayKey
{//http://zuul.manjiwang.com/elasticsearch/
    return @"elasticsearch";
}

////为某些Service需要拼凑额外的HTTPToken，如accessToken
- (NSDictionary *)extraHttpHeadParmas {
    NSString *sessionid = @"";
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary *httpHeadParmas = [NSMutableDictionary dictionary];
    [httpHeadParmas addEntriesFromDictionary:@{
                                                    @"loginType":@"App_IOS",
                                                    @"sessionID":sessionid?sessionid:@"",
//                                                    @"device":[Hardwaremodel platformString],
//                                                    @"appVersion":[InterfaceConfiguration shareInterfaceConfiguration].app_version,
//                                                    @"apiVersion":[InterfaceConfiguration shareInterfaceConfiguration].api_version,
//                                                    @"sysVersion":[InterfaceConfiguration shareInterfaceConfiguration].sys_version,
//                                                    @"roundNumber":@"",
                                                    @"deviceid":uuid?uuid:@""
                                                    }];
//    if ([CTNetworkingConfigurationManager sharedInstance].shouldSetParamsInHTTPBodyButGET) {
////        [self.httpHeadParmas setObject:@"application/json" forKey:@"Content-Type"];
////        [self.httpHeadParmas setObject:@"application/json" forKey:@"Accept"];
////        [self.httpHeadParmas setObject:@"text/plain" forKey:@"Accept"];
////        [self.httpHeadParmas setObject:@"text/json" forKey:@"Accept"];
//        [httpHeadParmas setObject:@"text/javascript" forKey:@"Accept"];
//
//        [httpHeadParmas setObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
//    }
//    [httpHeadParmas setObject:@"text/javascript" forKey:@"Accept"];
//
//    [httpHeadParmas setObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    [httpHeadParmas setObject:@"application/json" forKey:@"Content-Type"];
    [httpHeadParmas setObject:@"application/json" forKey:@"Accept"];
    return httpHeadParmas;
}

- (NSInteger)normalResultsCode {
    return 10000;
}

/** 状态码默认的key */
- (NSString *)codeString {
    return @"code";
}

/** 结果说明 默认的key*/
- (NSString *)descString {
    return @"message";
}

/** 数据默认的key */
- (NSString *)dataString {
    return @"result";
}


@end
