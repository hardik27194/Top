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
@end


@interface TopBackendLessUserData : NSObject
+(void)loginUserWithEmail:(NSString *)email
                      pwd:(NSString *)pwd
               completion:(void(^)(id user,NSError *error))completionBlock;
+(void)logoutUser:(void(^)(BOOL success,NSError *error))completionBlock;
+(void)registerUserWithName:(NSString *)name
                    surname:(NSString *)surname
                        pwd:(NSString *)pwd
                      email:(NSString *)email
                 completion:(void(^)(id user,NSError *error))completionBlock;



+(void)addStickers:(NSArray *)stickerNumbers
            toUser:(TopUser *)topUser
        completion:(void(^)(BOOL success,NSError *error))completionBlock;
+(void)removeStickers:(NSArray *)stickerNumbers
             fromUser:(TopUser *)topUser
           completion:(void(^)(BOOL success,NSError *error))completionBlock;
+(void)removeAllStickerFromUser:(TopUser *)topUser completion:(void(^)(BOOL success,NSError *error))completionBlock;
@end
