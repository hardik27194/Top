//
//  TopBackendLessUserData.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopUser : NSObject
+(TopUser *)initializeFromBackendLessUser:(id)bUser;
-(NSArray *)stickers;
-(NSInteger)packetsCount;
-(NSArray *)tmpStickers;
@end


@interface TopBackendLessUserData : NSObject
// User Data
+ (void)loginUserWithEmail:(NSString *)email
                      pwd:(NSString *)pwd
               completion:(void(^)(id user,NSError *error))completionBlock;
+ (void)logoutUser:(void(^)(BOOL success,NSError *error))completionBlock;
+ (void)registerUserWithName:(NSString *)name
                    surname:(NSString *)surname
                        pwd:(NSString *)pwd
                      email:(NSString *)email
                 completion:(void(^)(id user,NSError *error))completionBlock;

// Stickers
+ (void)addStickers:(NSArray *)stickerNumbers
            toUser:(TopUser *)topUser
        completion:(void(^)(BOOL success,NSError *error))completionBlock;
+ (void)removeStickers:(NSArray *)stickerNumbers
             fromUser:(TopUser *)topUser
           completion:(void(^)(BOOL success,NSError *error))completionBlock;
+ (void)removeAllStickersFromUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock;

// Tmp Stickers
+(void)removeTmpStickers:(NSArray *)stickerNumbers
                fromUser:(TopUser *)topUser
              completion:(void(^)(BOOL success,NSError *error))completionBlock;
+(void)addTmpStickers:(NSArray *)stickerNumbers
               toUser:(TopUser *)topUser
           completion:(void(^)(BOOL success,NSError *error))completionBlock;


// Packets
+ (void)addPackets:(NSInteger)numberPackets toUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock;
+ (void)removePacketFromUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock;

@end
