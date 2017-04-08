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
        self.iconLabel.text = @"doubles";
    }
    return self;
}
-(void)handleStickerNumber:(NSInteger)number completion:(void (^)(BOOL success))completion{
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
-(void)checkDouble:(NSInteger)number completion:(void (^)(BOOL isDouble))completion{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    if ([user.stickers containsObject:@(number)]) {
        completion(true);
    }else{
        completion(false);
    }
}
-(void)relax{
    self.backgroundColor = [UIColor lightGrayColor];
}
-(void)highlightWithNumber:(NSInteger)number{
    [self checkDouble:number
           completion:^(BOOL isDouble) {
               if (isDouble) {
                   self.backgroundColor = [UIColor greenColor];
               }else{
                   self.backgroundColor = [UIColor yellowColor];
               }
    }];
}

@end
