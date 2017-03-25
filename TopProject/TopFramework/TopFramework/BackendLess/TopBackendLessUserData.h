//
//  TopBackendLessUserData.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopBackendLessUserData : NSObject
+(void)loginUserWithEmail:(NSString *)email
                      pwd:(NSString *)pwd
               completion:(void(^)(NSDictionary *data,NSError *error))completionBlock;
+(void)logoutUser:(void(^)(BOOL success,NSError *error))completionBlock;
+(void)registerUserWithName:(NSString *)name
                    surname:(NSString *)surname
                        pwd:(NSString *)pwd
                      email:(NSString *)email
                 completion:(void(^)(NSDictionary *data,NSError *error))completionBlock;

@end
