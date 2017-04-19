//
//  TopBarMenu.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBarMenu.h"
@interface TopBarMenu(){
    NSMutableArray <TopBarButton*>* _buttons;
}
@end
@implementation TopBarMenu
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _buttons = [[NSMutableArray alloc]init];

    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttons = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)addButton:(TopBarButton *)button{
    [_buttons addObject:button];
    [self addSubview:button];
    [self refreshLayout];
}
-(void)removeButton:(TopBarButton *)button{
    if ([_buttons containsObject:button]) {
        [_buttons removeObject:button];
        [button removeFromSuperview];
    }
    [self refreshLayout];
}
-(NSArray<TopBarButton *> *)allButtons{
    return _buttons;
}
-(void)refreshLayout{
    NSInteger offsetX = 0;
    for (TopBarButton *button in _buttons) {
        NSInteger buttonWidth = self.bounds.size.width/_buttons.count;
        [button update];
        [UIView animateWithDuration:0.1 animations:^{
            button.frame = CGRectMake(offsetX, 0, buttonWidth, self.bounds.size.height);
        } completion:^(BOOL finished) {
            
        }];
        offsetX+= buttonWidth;
    }
}
-(void)update{
    [self refreshLayout];
}
@end
