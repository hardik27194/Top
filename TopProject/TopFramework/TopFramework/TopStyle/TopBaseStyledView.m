//
//  TopBaseStyledView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopBaseStyledView.h"
#import "TopStyleDirector.h"

@interface TopBaseStyledView (){
    NSMutableDictionary *_styles;
}
@end

@implementation TopBaseStyledView
@synthesize styleState = _styleState;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self innerInit];
    }
    return self;
}
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
    
    
    TopStyle *normalStyle = [[TopStyleDirector sharedDirector] styleForView:self
                                                                   forState:TopViewStyleState_Normal];
    
    [self setStyle:normalStyle forState:TopViewStyleState_Normal];
    
    
    
    TopStyle *selectedStyle = [[TopStyleDirector sharedDirector] styleForView:self
                                                                     forState:TopViewStyleState_Selected];
    [self setStyle:selectedStyle forState:TopViewStyleState_Selected];
    
    TopStyle *highlightStyle = [[TopStyleDirector sharedDirector] styleForView:self
                                                                      forState:TopViewStyleState_Highlighted];
    [self setStyle:highlightStyle forState:TopViewStyleState_Highlighted];
    
    TopStyle *warningStyle = [[TopStyleDirector sharedDirector] styleForView:self
                                                                    forState:TopViewStyleState_Warning];
    [self setStyle:warningStyle forState:TopViewStyleState_Warning];
    
}
-(void)setStyle:(TopStyle *)style
       forState:(TopViewStyleState)styleState{
    _styles[@(styleState)] = style;
}
-(void)setStyleState:(TopViewStyleState)styleState{
    _styleState = styleState;
    TopStyle *style = _styles[@(styleState)];
    [self applyStyle:style];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    TopStyle *style = _styles[@(_styleState)];
    [self applyStyle:style];
}

-(void)applyStyle:(TopStyle *)style{
    self.backgroundColor = style.backgroundColor;
    self.layer.borderColor = [style.layerBorderColor CGColor];
    self.layer.borderWidth = style.layerBorderWidth;
    self.layer.cornerRadius = style.layerCornerRadius;
    self.layer.masksToBounds = style.maskToBounds;
}
@end
