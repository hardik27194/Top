//
//  TopBarButton.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBarButton.h"
@interface TopBarButton()


@end

@implementation TopBarButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *iconLabel = [[UILabel alloc]init];
        iconLabel.textAlignment = NSTextAlignmentCenter;
        iconLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:iconLabel];
        self.iconLabel = iconLabel;
        
        UILabel *valueLabel = [[UILabel alloc]init];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:valueLabel];
        self.valueLabel = valueLabel;
           [self addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)relax{
    [self setStyleState:TopViewStyleState_Normal];
}
-(void)pressed{}
-(void)update{}
-(void)highlightWithNumber:(NSInteger)number{
    [self setStyleState:TopViewStyleState_Highlighted];
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    NSInteger iconHeight = 0;
    NSInteger valueHeight = 0;
    if (self.iconLabel.text != nil) {
        iconHeight = frame.size.height;
    }
    if (self.valueLabel.text != nil) {
        iconHeight = frame.size.height/3*2;
        valueHeight = frame.size.height/3*1;

    }
    self.iconLabel.frame = CGRectMake(0, 0, frame.size.width,iconHeight);
    self.valueLabel.frame = CGRectMake(0, iconHeight, frame.size.width, valueHeight);
}
-(void)handleStickerNumber:(NSInteger)number completion:(void (^)(BOOL))completion{}

#pragma mark - custom styles -
-(void)applyStyle:(TopStyle *)style{
    self.iconLabel.textColor = style.textColor;
    self.iconLabel.font = style.textFont;
    self.valueLabel.font = style.supporTextFont;
    self.valueLabel.textColor = style.supporTextColor;
}
@end
