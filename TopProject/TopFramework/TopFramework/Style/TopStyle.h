//
//  TopStyle.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef enum{
    TopViewStyleState_Normal,
    TopViewStyleState_Highlighted,
    TopViewStyleState_Selected,
    TopViewStyleState_Warning,
    TopViewStyleState_Disabled
} TopViewStyleState;


#import "TopStyleUtils.h"

@interface TopStyle : NSObject

// view
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,strong) UIColor *tintColor;


// layer
@property (nonatomic,assign) CGFloat layerBorderWidth;
@property (nonatomic,strong) UIColor *layerBorderColor;
@property (nonatomic,assign) CGFloat layerCornerRadius;
@property (nonatomic,assign) BOOL maskToBounds;
@property (nonatomic,strong) UIImage *layerBackgroundImage;


// label
@property (nonatomic,assign) NSTextAlignment textAlign;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,assign) NSTextAlignment supportTextAlign;
@property (nonatomic,strong) UIFont *supporTextFont;
@property (nonatomic,strong) UIColor *supporTextColor;


@end
