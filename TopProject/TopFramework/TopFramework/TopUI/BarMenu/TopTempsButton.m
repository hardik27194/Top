//
//  TopTmpStickers.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 09/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopTempsButton.h"
#import "TopAppDelegate.h"
#import "TopTileSticker.h"
#import "TopStickSessionDirector.h"

@interface TopTempsButton(){
    NSInteger _index;
}
@end
@implementation TopTempsButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iconLabel.text = @"tmp";
        self.valueLabel.text = nil;
        _index = 0;
    }
    return self;
}

-(void)pressed{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    if (user == nil) {
        self.valueLabel.text = nil;
        return;
    }
    _index ++;
    if (_index == [user tmpStickers].count) {
        _index = 0;
    }
    
    if (_index >= [user tmpStickers].count ) {
        self.valueLabel.text = nil;
        return;
    }
    NSNumber *number = [user tmpStickers][_index];
    self.valueLabel.text = [NSString stringWithFormat:@"%i",(int)[number integerValue]];
}

-(void)longPressBegan{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    if (user == nil) {
        self.valueLabel.text = nil;
        return;
    }
    if (_index >=  [user tmpStickers].count) {
        return;
    }
    NSNumber *number = [user tmpStickers][_index];
    [TopBackendLessUserData removeTmpStickers:@[number] fromUser:user completion:^(BOOL success, NSError *error) {
        if (error == nil){
            TopTileSticker *sticker = [[TopTileSticker alloc]initWithFrame:CGRectMake(50, 400, 100, 100) andNumber:[number integerValue]];
            [[TopStickSessionDirector sharedDirector] addTileStickers:@[sticker] animation:^{
            }];
            _index --;
            [self pressed];
        }
    }];
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
}
-(void)update{
    [self updateStickersCount];
}
-(void)updateStickersCount{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    self.valueLabel.text = [NSString stringWithFormat:@"%i",(int)user.tmpStickers.count];
}

@end
