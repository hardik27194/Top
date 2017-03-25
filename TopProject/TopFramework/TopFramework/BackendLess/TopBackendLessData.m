//
//  TopBackendLessData.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBackendLessData.h"
#import "Backendless.h"
#import "TopAppDelegate.h"

@implementation TopBackendLessData

#pragma mark - data -
+(NSArray<TopPage *>*)getAllTopPages{
    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    id <IDataStore> pages = [backendless.persistenceService of:topConfiguration.topPageClass];
    BackendlessCollection *collection = [pages find];
    return collection.data;
}
@end
