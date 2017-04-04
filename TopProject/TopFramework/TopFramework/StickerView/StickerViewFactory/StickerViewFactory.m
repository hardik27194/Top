//
//  StickerViewFactory.m
//  TopFramework
//
//  Created by Makeitapp USA on 03/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerViewFactory.h"

static NSDictionary *stickerViews;
@implementation StickerViewFactory
+(void)load{
     stickerViews = @{@"default":@"StickerViewTmpl0",
                      @"tmpl0":@"StickerViewTmpl0",
                      @"tmpl1":@"StickerViewTmpl1"};
}
+(StickerView *)stickerViewFromIdentifier:(NSString *)identifier{
    
    if(identifier == nil){
        return nil;
    }
    NSString *stickerViewNibName = stickerViews[identifier];
    if (stickerViewNibName == nil) {
        stickerViewNibName = stickerViews[@"default"];
    }
    
    StickerView *stickerView = [StickerView stickerViewWithIdentifier:stickerViewNibName];
    return stickerView;
}
@end
