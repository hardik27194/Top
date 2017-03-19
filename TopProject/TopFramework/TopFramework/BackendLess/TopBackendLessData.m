//
//  TopBackendLessData.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBackendLessData.h"
#import "Backendless.h"


@implementation TopBackendLessData

+(NSArray<TopPage *>*)getAllPages{
    id <IDataStore> pages = [backendless.persistenceService of:[TopPage class]];
    BackendlessCollection *collection = [pages find];
    return collection.data;
}
@end
