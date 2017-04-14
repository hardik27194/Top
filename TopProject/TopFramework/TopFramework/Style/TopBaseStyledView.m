//
//  TopBaseStyledView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBaseStyledView.h"

@interface TopBaseStyledView (){
    NSMutableDictionary *_styles;
}
@end

@implementation TopBaseStyledView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self innerInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self innerInit];
    }
    return self;
}
-(void)innerInit{
    _styles = [[NSMutableDictionary alloc]init];
    _styleState = TopViewStyleState_Normal;
}
-(void)setStyle:(TopStyle *)style
       forState:(TopViewStyleState)styleState{
    _styles[@(styleState)] = style;
}
-(void)setStyleState:(TopViewStyleState)styleState{
    _styleState = styleState;
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    TopStyle *style = _styles[@(self.styleState)];
    
    self.backgroundColor = style.backgroundColor;
    self.layer.borderColor = [style.layerBorderColor CGColor];
    self.layer.borderWidth = style.layerBorderWidth;
    self.layer.cornerRadius = style.layerCornerRadius;
    self.layer.masksToBounds = style.maskToBounds;
}

@end
