//
//  TopLayoutFactory.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopLayoutFactory.h"
#import "TopLayout1_Tmpl0.h"
#import "TopLayout3_Tmpl0.h"
#import "TopLayout4_Tmpl0.h"

static NSDictionary *layouts;

@interface TopLayoutFactory()
@end

@implementation TopLayoutFactory
+(void)load{
    
    NSDictionary *layout_1_obj = @{@"l1_tmpl0":[TopLayout1_Tmpl0 class]};
    NSDictionary *layout_3_obj = @{@"l3_tmpl0":[TopLayout3_Tmpl0 class]};
    NSDictionary *layout_4_obj = @{@"l4_tmpl0":[TopLayout4_Tmpl0 class]};

    layouts = @{@1:layout_1_obj,
                @3:layout_3_obj,
                @4:layout_4_obj};
    
}
+(BasePageViewController *)layoutFromTopPage:(TopPage *)topPage{
    
    if (topPage == nil) {
        return nil;
    }
    
    if (topPage.number < 0) {
        return nil;
    }
    
    NSNumber *countObjectsInPage = [NSNumber numberWithUnsignedInteger:topPage.topObjects.count];
    NSDictionary *layoutDict = [layouts objectForKey:countObjectsInPage];
    if (layoutDict == nil) {
        NSLog(@"Top Error: there is no layout with %i objects",(int)countObjectsInPage);
        return nil;
    }
    
    if (topPage.layoutName == nil) {
        return nil;
    }
    
    Class layoutClass = [layoutDict objectForKey:topPage.layoutName];
    if (layoutClass == nil) {
        NSLog(@"Top Error: there is no layout name %@ ",topPage.layoutName);
        return nil;
    }
    
    BasePageViewController *layoutController = [[layoutClass alloc]initWithTopPage:topPage];
    return layoutController;
}
@end
