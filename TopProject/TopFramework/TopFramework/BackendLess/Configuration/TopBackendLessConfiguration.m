//
//  TopBackendLessConfiguration.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBackendLessConfiguration.h"
#import "Backendless.h"
#import "TopBackendLessData.h"

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
@interface TopBackendLessConfiguration(){
    TopConfiguration *_configuration;
}

@end
@implementation TopBackendLessConfiguration
- (instancetype)initWithConfiguration:(TopConfiguration *)configuration
{
    self = [super init];
    if (self) {
        _configuration = configuration;
    }
    return self;
}
-(TopConfiguration *)configuration{
    return _configuration;
}
+(instancetype)initWithAppId:(NSString *)appIDKey
              secret:(NSString *)secretKey
             version:(NSString *)versionKey
             configurationId:(NSString *)confID{
    
    [[Backendless sharedInstance] initApp:appIDKey
                                   secret:secretKey
                                  version:versionKey];
    
    TopConfiguration *configuration;
    if ( IDIOM == IPAD ) {
        configuration  = [[TopBackendLessData getConfigurationWithClass:[TopIPadConfiguration class]] objectAtIndex:0];
    } else {
        configuration  = [[TopBackendLessData getConfigurationWithClass:[TopIPhoneConfiguration class]] objectAtIndex:0];
    }
    return [[TopBackendLessConfiguration alloc]initWithConfiguration:configuration];
}

@end
