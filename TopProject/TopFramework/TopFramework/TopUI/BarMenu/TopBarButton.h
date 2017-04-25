//
//  TopBarButton.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBaseStyledButton.h"

@interface TopBarButton : TopBaseStyledButton
@property (nonatomic,weak) UILabel *iconLabel;
@property (nonatomic,weak) UILabel *valueLabel;
-(void)longPressBegan;
-(void)longPressEnd;
-(void)pressed;
-(void)update;
-(void)relax;
-(void)highlightWithNumber:(NSInteger)number;
-(void)handleStickerNumber:(NSInteger)number completion:(void (^)(BOOL success))completion;
@end
