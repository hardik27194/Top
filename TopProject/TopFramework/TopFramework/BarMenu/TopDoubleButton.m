//
//  TopDoubleStickers.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopDoubleButton.h"
#import "TopAppDelegate.h"

@implementation TopDoubleButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iconLabel.text = @"\uf0c5";
    }
    return self;
}
#pragma mark - public -
-(void)handleStickerNumber:(NSInteger)number
                completion:(void (^)(BOOL success))completion{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    [self checkDouble:number completion:^(BOOL isDouble) {
        if (isDouble) {
            [TopBackendLessUserData addStickers:@[@(number)] toUser:user completion:^(BOOL success, NSError *error) {
                completion(success);
            }];
        }else{
            completion(false);
        }
    }];
}

-(void)relax{
    [super relax];
}
-(void)highlightWithNumber:(NSInteger)number{
    [self checkDouble:number
           completion:^(BOOL isDouble) {
               if (isDouble) {
                   [self setStyleState:TopViewStyleState_Highlighted];
               }else{
                   [self setStyleState:TopViewStyleState_Warning];
               }
    }];
}
#pragma mark - private -
-(void)checkDouble:(NSInteger)number completion:(void (^)(BOOL isDouble))completion{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    if ([user.stickers containsObject:@(number)]) {
        completion(true);
    }else{
        completion(false);
    }
}
@end
