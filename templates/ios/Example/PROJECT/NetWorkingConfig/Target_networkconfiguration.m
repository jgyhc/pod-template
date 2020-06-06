//
//  Target_networkconfiguration.m
//  MJNetWorkKit_Example
//
//  Created by manjiwang on 2018/12/28.
//  Copyright © 2018 刘聪. All rights reserved.
//

#import "Target_networkconfiguration.h"
//#import <MJUserInstance.h>
#import "CTMediator.h"

@implementation Target_networkconfiguration

- (id)Action_apiBaseUrl:(NSDictionary *)params {
//    return @"http://zuul.manjiwangdev.com";
    return @"http://zuul.manjiwangtest.com";
//    return @"http://zuul.manjiwang.com";
//    return @"https://05301ec5-d8ce-4b00-8241-6027851a8e68.mock.pstmn.io";
}

- (id)Action_gatewayKey:(NSDictionary *)params {
    return @"";
}

- (id)Action_publicKey:(NSDictionary *)params {
    return @"";
}

- (id)Action_privateKey:(NSDictionary *)params {
    return @"";
}

- (id)Action_extraParmas:(NSDictionary *)params {
    return @"";
}

- (id)Action_extraHttpHeadParmas:(NSDictionary *)params {
    NSString *sessionid = [[CTMediator sharedInstance] performTarget:@"userInstance" action:@"sessionId" params:nil shouldCacheTarget:YES];;
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *device = @"iphone";
    NSString *appVersion = @"6.9.0";
    NSString *sysVersion = @"11.0";
    NSString *apiVersion = @"6.9.0";
    NSMutableDictionary *httpHeadParmas = [NSMutableDictionary dictionary];
    if (sessionid) {
        [httpHeadParmas setObject:sessionid forKey:@"sessionID"];
    }
    
    if (uuid) {
        [httpHeadParmas setObject:uuid forKey:@"deviceid"];
    }
    if (device) {
        [httpHeadParmas setObject:device forKey:@"device"];
    }
    
    if (appVersion) {
        [httpHeadParmas setObject:appVersion forKey:@"appVersion"];
    }
    
    if (apiVersion) {
        [httpHeadParmas setObject:apiVersion forKey:@"apiVersion"];
    }
    if (sysVersion) {
        [httpHeadParmas setObject:sysVersion forKey:@"sysVersion"];
    }
    [httpHeadParmas setObject:@"App_IOS" forKey:@"loginType"];
//    if ([CTNetworkingConfigurationManager sharedInstance].shouldSetParamsInHTTPBodyButGET) {
//        [self.httpHeadParmas setObject:@"application/json" forKey:@"Content-Type"];
//        [self.httpHeadParmas setObject:@"application/json" forKey:@"Accept"];
//    }
    [httpHeadParmas setObject:@"application/json" forKey:@"Content-Type"];
    [httpHeadParmas setObject:@"application/json" forKey:@"Accept"];
//
//    return self.httpHeadParmas;
//
    return httpHeadParmas;
}

- (id)Action_loginFailureCode:(NSDictionary *)params {
    return @101;
}

- (id)Action_codeString:(NSDictionary *)params {
    return @"Code";
}

- (id)Action_messageString:(NSDictionary *)params {
    return @"Desc";
}

- (id)Action_dataString:(NSDictionary *)params {
    return @"Data";
}

- (id)Action_normalResultsCode:(NSDictionary *)params {
    return @1;
}

- (id)Action_resetLogin:(NSDictionary *)params {
    return @(NO);
}

- (id)Action_otherFailure:(NSDictionary *)params {
    return @(NO);
}

@end
