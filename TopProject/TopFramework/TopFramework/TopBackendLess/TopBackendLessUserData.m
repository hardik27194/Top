//
//  TopBackendLessUserData.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBackendLessUserData.h"
#import "Backendless.h"
#import "TopPacket.h"

static NSArray *stickersArrayFromString(NSString *stickersString){
    NSMutableArray *numberStickers = [[NSMutableArray alloc]init];
    if (stickersString == nil || [stickersString isKindOfClass:[NSNull class]]) {
        return numberStickers;
    }
    if (stickersString.length == 0) {
        return numberStickers;
    }
    for (NSString *stickerNumberString in [stickersString componentsSeparatedByString:@":"]) {
        [numberStickers addObject:[NSNumber numberWithInteger:[stickerNumberString integerValue]]];
    }
    
    return numberStickers;
}
static NSString *stickersStringFromArray(NSArray *stickerArray){
    return [stickerArray componentsJoinedByString:@":"];
}

@interface TopUser()
@property (nonatomic,assign) NSInteger packetsCount;
@property (nonatomic,strong) NSArray *stickers;
@property (nonatomic,strong) NSArray *tmpStickers;

@property (nonatomic,strong,readonly) BackendlessUser *backendLessUser;
@end

@implementation TopUser

+(TopUser *)initializeFromBackendLessUser:(id)bUser{
    BackendlessUser *backendLessUser = (BackendlessUser *)bUser;
    if (![bUser isKindOfClass:[BackendlessUser class]]) {
        return nil;
    }
    
    NSDictionary *allProperties = [backendLessUser retrieveProperties];
    TopUser *topUser = [[TopUser alloc]init];
    topUser->_backendLessUser = bUser;
    topUser->_stickers = stickersArrayFromString(allProperties[@"stickers"]);
    topUser->_tmpStickers = stickersArrayFromString(allProperties[@"tmp_stickers"]);
    topUser->_packetsCount = [allProperties[@"packets"] integerValue];
    
    return topUser;
}
-(NSArray *)stickers{
    NSDictionary *allProperties = [self->_backendLessUser retrieveProperties];
    return stickersArrayFromString(allProperties[@"stickers"]);
}
-(NSInteger)packetsCount{
    NSDictionary *allProperties = [self->_backendLessUser retrieveProperties];
    return [allProperties[@"packets"] integerValue];
}
-(NSArray *)tmpStickers{
    NSDictionary *allProperties = [self->_backendLessUser retrieveProperties];
    return stickersArrayFromString(allProperties[@"tmp_stickers"]);
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
        NSError *error = [NSError errorWithDomain:fault.message code:[fault.faultCode integerValue] userInfo:nil];
        completionBlock(nil,error);
    }];
    
}

+(void)logoutUser:(void(^)(BOOL success,NSError *error))completionBlock{
    Fault *fault = nil;
    BOOL success = [backendless.userService logoutError:&fault];
    NSError *error = nil;
    if (fault != nil) {
        error =  [NSError errorWithDomain:fault.message code:[fault.faultCode integerValue] userInfo:nil];
    }
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
        NSError *error = [NSError errorWithDomain:fault.description code:fault.faultCode userInfo:nil];
        completionBlock(nil,error);
    }];
}
#pragma mark -
+(void)updateUser:(BackendlessUser *)backendLessUser
       completion:(void(^)(BOOL success,NSError *error))completionBlock{
    
    [backendless.userService update:backendLessUser response:^(BackendlessUser *userObject) {
        completionBlock(YES,nil);
    } error:^(Fault *fault) {
        NSError *error = [NSError errorWithDomain:fault.description code:fault.faultCode userInfo:nil];
        completionBlock(NO,error);
    }];
}
#pragma mark - tmpStickers -
+(void)removeTmpStickers:(NSArray *)stickerNumbers fromUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"You are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    if (stickerNumbers == nil) {
        return;
    }
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    NSMutableArray *mutStickers = [[NSMutableArray alloc]initWithArray:topUser.tmpStickers];
    [mutStickers removeObjectsInArray:stickerNumbers];
    topUser.stickers = (NSArray *)mutStickers;
    NSString *stickerString = stickersStringFromArray(mutStickers);
    [backendLessUser updateProperties:@{@"tmp_stickers":stickerString}];
    
    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
                            }];
}
+(void)addTmpStickers:(NSArray *)stickerNumbers toUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"you are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    if (stickerNumbers == nil) {
        return;
    }
    
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    NSMutableArray *mutStickers = [[NSMutableArray alloc]initWithArray:topUser.tmpStickers];
    [mutStickers addObjectsFromArray:stickerNumbers];
    NSString *stickerString = stickersStringFromArray(mutStickers);
    topUser.tmpStickers = (NSArray *)mutStickers;
    [backendLessUser updateProperties:@{@"tmp_stickers":stickerString}];
    
    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
                            }];
}
#pragma mark - Stickers -
+(void)addStickers:(NSArray *)stickerNumbers toUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"you are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    if (stickerNumbers == nil) {
        return;
    }
   
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    NSMutableArray *mutStickers = [[NSMutableArray alloc]initWithArray:topUser.stickers];
    [mutStickers addObjectsFromArray:stickerNumbers];
    NSString *stickerString = stickersStringFromArray(mutStickers);
    topUser.stickers = (NSArray *)mutStickers;
    [backendLessUser updateProperties:@{@"stickers":stickerString}];
    
    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
    }];
}
+(void)removeStickers:(NSArray *)stickerNumbers fromUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"You are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    if (stickerNumbers == nil) {
        return;
    }
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    NSMutableArray *mutStickers = [[NSMutableArray alloc]initWithArray:topUser.stickers];
    [mutStickers removeObjectsInArray:stickerNumbers];
    topUser.stickers = (NSArray *)mutStickers;
    NSString *stickerString = stickersStringFromArray(mutStickers);
    [backendLessUser updateProperties:@{@"stickers":stickerString}];

    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
    }];
}
+(void)removeAllStickersFromUser:(TopUser *)topUser completion:
(void(^)(BOOL success,NSError *error))completionBlock{
    
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"You are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
   
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    [backendLessUser updateProperties:@{@"stickers":@""}];
    
    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
                            }];
}
#pragma mark - packets -
+(void)addPackets:(NSInteger)numberPackets toUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"You are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    NSInteger userPackets = topUser.packetsCount;
    userPackets += numberPackets;
    topUser.packetsCount = userPackets;
    [backendLessUser updateProperties:@{@"packets":@(userPackets)}];
    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
                            }];
}
+(void)removePacketFromUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock{
    if (topUser == nil){
        NSError *error = [NSError errorWithDomain:@"You are not logged in" code:0 userInfo:nil];
        completionBlock(NO,error);
        return;
    }
    
    BackendlessUser *backendLessUser = topUser.backendLessUser;
    NSInteger userPackets = topUser.packetsCount;
    if (userPackets<= 0) {
        return;
    }
    userPackets--;
    topUser.packetsCount = userPackets;
    [backendLessUser updateProperties:@{@"packets":@(userPackets)}];
    [TopBackendLessUserData updateUser:backendLessUser
                            completion:^(BOOL success, NSError *error) {
                                completionBlock(success,error);
                            }];
    
}
@end
