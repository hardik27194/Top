//
//  TopBackendLessUserData.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBackendLessUserData.h"
#import "Backendless.h"
#import "TopAppDelegate.h"

@implementation TopBackendLessUserData
+(void)loginUserWithEmail:(NSString *)email
                     pwd:(NSString *)pwd
              completion:(void(^)(NSDictionary *data,NSError *error))completionBlock{
    BackendlessUser *user = [[BackendlessUser alloc]init];
    [user setPassword:pwd];
    [user setProperty:@"email" object:email];
    NSError *error = nil;

    BackendlessUser *userObject = [backendless.userService login:email password:pwd error:&error];
    completionBlock([userObject retrieveProperties],error);
}

+(void)logoutUser:(void(^)(BOOL success,NSError *error))completionBlock{
    NSError *error = nil;
    BOOL success = [backendless.userService logoutError:&error];
    completionBlock(success,error);
}

+(void)registerUserWithName:(NSString *)name
                    surname:(NSString *)surname
                        pwd:(NSString *)pwd
                      email:(NSString *)email
                 completion:(void(^)(NSDictionary *data,NSError *error))completionBlock{
    
    BackendlessUser *user = [[BackendlessUser alloc]init];
    [user setPassword:pwd];
    [user setProperty:@"email" object:email];
    [user setName:[NSString stringWithFormat:@"%@ %@",name,surname]];
    
    NSError *error = nil;
    BackendlessUser *userObject = [backendless.userService registering:user error:&error];
    completionBlock([userObject retrieveProperties],error);
}

@end
