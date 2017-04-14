//
//  AppDelegate.m
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "AppDelegate.h"
#import "TopAnimalPage.h"
#import "TopAnimalObject.h"
#import "TopAnimalCategory.h"
#import "TopAnimalStyler.h"

#define kAppId @"AE9C432A-B676-3C1A-FF5E-DE20C1F98600"
#define kSecretKey @"17FE72FF-30B0-AC01-FFF5-DEAF9C87F100"
#define kVersion @"v1"
#define kConfigurationIdKey @"TopAnimalConfiguration"
@interface AppDelegate ()<TopAppDelegatePublicProtocol>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.backendlessConfiguration = [TopBackendLessConfiguration initWithAppId:kAppId
                                                                        secret:kSecretKey
                                                                        version:kVersion
                                                                configurationId:kConfigurationIdKey];
    
    self.backendlessConfiguration.topObjectClass = [TopAnimalObject class];
    self.backendlessConfiguration.topPageClass = [TopAnimalPage class];
    self.backendlessConfiguration.topCategoryClass = [TopAnimalCategory class];
    
    self.stylerClass = [TopAnimalStyler class];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
-(void)loadStyles{
    
    TopStyle *defaultStyle = [[TopStyle alloc]init];
    defaultStyle.backgroundColor = [TopStyleUtils colorFromHexString:@"efefef" withAlpha:1];
    defaultStyle.layerBorderWidth = 1;
    defaultStyle.layerCornerRadius = 10;
    defaultStyle.layerBorderColor = [TopStyleUtils colorFromHexString:@"333333" withAlpha:1];
    
    self.topStyles[@"default_style"] = defaultStyle;
    
}

@end
