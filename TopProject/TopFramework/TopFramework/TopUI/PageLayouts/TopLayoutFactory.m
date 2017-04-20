//
//  TopLayoutFactory.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopLayoutFactory.h"
#import "TopLayout1_Tmpl0.h"
#import "TopLayout2_Tmpl0.h"
#import "TopLayout2_Tmpl1.h"
#import "TopLayout3_Tmpl0.h"
#import "TopLayout4_Tmpl0.h"


#import "TopIPadLayout2_Tmpl0.h"
#import "TopIPadLayout2_Tmpl1.h"

static NSDictionary *iPhoneLayouts;
static NSDictionary *iPadLayouts;

@interface TopLayoutFactory()
@end

@implementation TopLayoutFactory
+(void)load{
    
    NSDictionary *iphone_layout_1_obj = @{@"iphone_l1_tmpl0":[TopLayout1_Tmpl0 class]};
    NSDictionary *iphone_layout_2_obj = @{@"iphone_l2_tmpl0":[TopLayout2_Tmpl0 class],
                                          @"iphone_l2_tmpl1":[TopLayout2_Tmpl1 class]};
    NSDictionary *iphone_layout_3_obj = @{@"iphone_l3_tmpl0":[TopLayout3_Tmpl0 class]};
    NSDictionary *iphone_layout_4_obj = @{@"iphone_l4_tmpl0":[TopLayout4_Tmpl0 class]};

    iPhoneLayouts = @{@1:iphone_layout_1_obj,
                @2:iphone_layout_2_obj,
                @3:iphone_layout_3_obj,
                @4:iphone_layout_4_obj};
    
    NSDictionary *ipad_layout_2_obj = @{@"ipad_l2_tmpl0":[TopIPadLayout2_Tmpl0 class],
                                        @"ipad_l2_tmpl1":[TopIPadLayout2_Tmpl1 class]};

    iPadLayouts = @{
                    @2:ipad_layout_2_obj
                    
                    };
    
    
}
+(BasePageViewController *)layoutFromTopPage:(TopPage *)topPage{
    
    if (topPage == nil) {
        return nil;
    }
    
    if (topPage.index < 0) {
        return nil;
    }
    
    NSNumber *countObjectsInPage = [NSNumber numberWithUnsignedInteger:topPage.topObjects.count];
    
    NSDictionary *sourceDictionary = nil;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        sourceDictionary = iPadLayouts;
    } else {
        sourceDictionary = iPhoneLayouts;
    }
    
    NSDictionary *layoutDict = [sourceDictionary objectForKey:countObjectsInPage];
    if (layoutDict == nil) {
        NSLog(@"Top Error: there is no layout with %i objects",(int)countObjectsInPage);
        return nil;
    }
    
    NSString *layoutName = nil;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        layoutName = topPage.iPadLayoutName;
    } else {
        layoutName = topPage.iPhoneLayoutName;
    }
    
    if (layoutName == nil) {
        return nil;
    }
    
    Class layoutClass = [layoutDict objectForKey:layoutName];
    if (layoutClass == nil) {
        NSLog(@"Top Error: there is no layout name %@ ",layoutName);
        return nil;
    }
    
    BasePageViewController *layoutController = [[layoutClass alloc]initWithTopPage:topPage];
    return layoutController;
}


@end
