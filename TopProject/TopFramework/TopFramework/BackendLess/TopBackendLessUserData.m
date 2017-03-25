//
//  TopBackendLessUserData.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBackendLessUserData.h"
#import "Backendless.h"

@interface TopUser()
@property (nonatomic,strong) NSArray *stickers;
@property (nonatomic,strong,readonly) BackendlessUser *backendLessUser;
@end

@implementation TopUser

+(TopUser *)initializeFromBackendLessUser:(id)bUser{
    BackendlessUser *backendLessUser = (BackendlessUser *)bUser;
    if (![bUser isKindOfClass:[BackendlessUser class]]) {
        return nil;
    }
    TopUser *topUser = [[TopUser alloc]init];
    topUser->_backendLessUser = bUser;
    return topUser;
}


@end
@implementation TopBackendLessUserData
+(void)loginUserWithEmail:(NSString *)email
                     pwd:(NSString *)pwd
              completion:(void(^)(id user,NSError *error))completionBlock{
    BackendlessUser *user = [[BackendlessUser alloc]init];
    [user setPassword:pwd];
    [user setProperty:@"email" object:email];
    
    [backendless.userService login:email password:pwd response:^(BackendlessUser *userObject) {
        completionBlock(userObject,nil);

    } error:^(Fault *fault) {
        completionBlock(nil,fault);
    }];
    
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
                 completion:(void(^)(id user,NSError *error))completionBlock{
    
    BackendlessUser *user = [[BackendlessUser alloc]init];
    [user setPassword:pwd];
    [user setProperty:@"email" object:email];
    [user setName:[NSString stringWithFormat:@"%@ %@",name,surname]];
    
    [backendless.userService registering:user response:^(BackendlessUser *userObject) {
        completionBlock(userObject,nil);

    } error:^(Fault *fault) {
        completionBlock(nil,fault);
    }];
}
#pragma mark -
+(void)updateUser:(BackendlessUser *)backendLessUser
       completion:(void(^)(BOOL success,NSError *error))completionBlock{
    
    [backendless.userService update:backendLessUser response:^(BackendlessUser *userObject) {
        completionBlock(YES,nil);
    } error:^(Fault *fault) {
        completionBlock(NO,fault);
    } ];
}

#pragma mark - Stickers -
+(void)addStickers:(NSArray *)stickersNumber toUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"you are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    [backendLessUser updateProperties:@{@"stickers":@"ahahahaaha"}];
    
    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
    }];
}
+(void)removeStickers:(NSArray *)stickersNumber fromUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"you are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    [backendLessUser updateProperties:@{@"stickers":@"buahahhaha"}];

    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
    }];
}
@end
