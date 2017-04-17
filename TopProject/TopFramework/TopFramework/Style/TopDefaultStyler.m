//
//  TopDefaultStyler.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopDefaultStyler.h"

@implementation TopDefaultStyler

-(TopStyle *)styleForStickerView:(TopBaseStyledView *)view
                        forState:(TopViewStyleState)state{
    TopStyle *style = [[TopStyle alloc]init];
    
    switch (state) {
        case TopViewStyleState_Normal:{
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"efefef" withAlpha:1];
            style.textFont = [UIFont boldSystemFontOfSize:20];
            style.textColor = [TopStyleUtils colorFromHexString:@"34495e" withAlpha:1];
            style.layerBorderWidth = 1;
            style.layerCornerRadius = 5;
            style.layerBorderColor = [TopStyleUtils colorFromHexString:@"d9d9d9" withAlpha:1];
            style.maskToBounds = YES;

        }
            break;
        case TopViewStyleState_Selected:{
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"DCC857" withAlpha:1];
            style.textFont = [UIFont boldSystemFontOfSize:20];
            style.textColor = [TopStyleUtils colorFromHexString:@"ecf0f1" withAlpha:1];
            style.layerBorderWidth = 0;
            style.layerCornerRadius = 10;
            style.maskToBounds = YES;

        }
            break;
            
        default:
            break;
    }
    
    
    return style;
}

-(TopStyle *)styleForPhotoStickerView:(TopBaseStyledView *)view
                             forState:(TopViewStyleState)state{
    TopStyle *style = [[TopStyle alloc]init];
    
    switch (state) {
        case TopViewStyleState_Normal:{
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"f6f6f6" withAlpha:1];
            style.maskToBounds = YES;
            style.layerBorderWidth = 1;
            style.layerCornerRadius = 0;
            style.layerBorderColor = [TopStyleUtils colorFromHexString:@"d9d9d9" withAlpha:1];
        }
            break;
        case TopViewStyleState_Highlighted:{
            style.maskToBounds = YES;
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"2ecc71" withAlpha:1];
            style.layerBorderWidth = 1;
            style.layerCornerRadius = 0;
            style.layerBorderColor = [TopStyleUtils colorFromHexString:@"d9d9d9" withAlpha:1];
        }
            break;
        case TopViewStyleState_Selected:{
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"efefef" withAlpha:1];
            style.maskToBounds = YES;
            style.layerBorderWidth = 0;
        }
        case TopViewStyleState_Warning:{
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"f39c12" withAlpha:1];
            style.maskToBounds = YES;
            style.layerBorderWidth = 0;
        }
        default:
            break;
    }
    
    
    return style;
    
}
@end
