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
        iconLabel.backgroundColor = [UIColor redColor];
        [self addSubview:iconLabel];
        self.iconLabel = iconLabel;
        
        UILabel *valueLabel = [[UILabel alloc]init];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:valueLabel];
        self.valueLabel = valueLabel;
           [self addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)pressed{}
-(void)update{}
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
