//
//  TopAnimalStylesConfiguration.m
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopAnimalStyler.h"

@implementation TopAnimalStyler
-(TopStyle *)styleForStickerView:(TopBaseStyledView *)view
                        forState:(TopViewStyleState)state{
    TopStyle *style = [[TopStyle alloc]init];
    
    switch (state) {
        case TopViewStyleState_Normal:{
            style.backgroundColor = [TopStyleUtils colorFromHexString:@"efefef" withAlpha:1];
            style.layerBorderWidth = 1;
            style.layerCornerRadius = 10;
            style.layerBorderColor = [TopStyleUtils colorFromHexString:@"333333" withAlpha:1];
        }
            break;
            
        default:
            break;
    }
    

    return style;
}    

@end
