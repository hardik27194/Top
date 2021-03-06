//
//  TopBackendLessData.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopPage.h"

@interface TopBackendLessData : NSObject

+(NSArray<TopCategory *>*)getAllTopCategories;
+(NSArray<TopPage *>*)getAllTopPages;
+(NSArray*)getConfigurationWithClass:(Class)deviceClass;

@end
