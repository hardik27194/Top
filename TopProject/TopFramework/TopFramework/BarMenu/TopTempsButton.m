//
//  TopTmpStickers.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 09/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopTempsButton.h"
#import "TopAppDelegate.h"

@implementation TopTempsButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iconLabel.text = @"tmp";
    }
    return self;
}

-(void)pressed{
    NSLog(@"add tmp stickers");
    // to do :  emit sticker
}

#pragma mark - public methods -
-(void)handleStickerNumber:(NSInteger)number
                completion:(void (^)(BOOL success))completion{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    [TopBackendLessUserData addTmpStickers:@[@(number)]
                                    toUser:user
                                completion:^(BOOL success, NSError *error) {
                                    if (success) {
                                        [self updateStickersCount];
                                    }
                                    completion(success);
    }];
}
-(void)relax{
    self.backgroundColor = [UIColor lightGrayColor];
}
-(void)highlightWithNumber:(NSInteger)number{
    self.backgroundColor = [UIColor brownColor];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateStickersCount];
}
-(void)update{
    [self updateStickersCount];
}
-(void)updateStickersCount{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    self.valueLabel.text = [NSString stringWithFormat:@"%i",(int)user.tmpStickers.count];
}

@end
