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
            style.layerBorderWidth = 1;
            style.layerCornerRadius = 5;
            style.layerBorderColor = [TopStyleUtils colorFromHexString:@"d9d9d9" withAlpha:1];
        }
            break;
        case TopViewStyleState_Selected:{
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"DCC857" withAlpha:1];
            style.layerBorderWidth = 0;
            style.layerCornerRadius = 10;
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
            style.layerBorderWidth = 1;
            style.layerCornerRadius = 0;
            style.layerBorderColor = [TopStyleUtils colorFromHexString:@"d9d9d9" withAlpha:1];
        }
        
            break;
            
        default:
            break;
    }
    
    
    return style;
    
}
@end
