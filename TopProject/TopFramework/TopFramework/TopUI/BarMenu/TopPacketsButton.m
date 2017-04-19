//
//  TopPacketsButton.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopPacketsButton.h"
#import "TopControllersDirector.h"
#import "TopAppDelegate.h"
#import "TopStyleDirector.h"

@implementation TopPacketsButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iconLabel.text = @"\uf06b";
        [self updatePacketsCount];
        
        

    }
    return self;
}

-(void)pressed{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;

    if ((int)user.packetsCount > 0) {
        [[TopControllersDirector sharedDirector] showUnPackControllerWithEndingBlock:^(id data) {
            [self updatePacketsCount];
        }];
    }else{
        // handle error
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self updatePacketsCount];
}
-(void)update{
    [self updatePacketsCount];
}
-(void)updatePacketsCount{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    self.valueLabel.text = [NSString stringWithFormat:@"%i",(int)user.packetsCount];
}

-(void)relax{
    [super relax];
}
-(void)highlightWithNumber:(NSInteger)number{
    [super highlightWithNumber:number];
}

-(void)handleStickerNumber:(NSInteger)number completion:(void (^)(BOOL success))completion{
    completion(false);
}

@end
