//
//  TopBackendLessConfiguration.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBackendLessConfiguration.h"
#import "Backendless.h"

@implementation TopBackendLessConfiguration
+(instancetype)initWithAppId:(NSString *)appIDKey
              secret:(NSString *)secretKey
             version:(NSString *)versionKey{
    
    [[Backendless sharedInstance] initApp:appIDKey
                                   secret:secretKey
                                  version:versionKey];
    
    
    return [[TopBackendLessConfiguration alloc]init];
}

@end
