//
//  TopBackendLessConfiguration.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopBackendLessConfiguration : NSObject
+(void)initBackendlessWithAppId:(NSString *)appIDKey
                         secret:(NSString*)secretKey
                        version:(NSString *)versionKey;
@end
