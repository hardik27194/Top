//
//  StickerViewFactory.m
//  TopFramework
//
//  Created by Makeitapp USA on 03/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerViewFactory.h"
#import "StickerViewTmpl0.h"

static NSDictionary *stickerViews;
@implementation StickerViewFactory
+(void)load{
     stickerViews = @{@"tmpl0":[StickerViewTmpl0 class]};
}
-(StickerView *)stickerViewFromIdentifier:(NSString *)identifier{
    
    
//    Clas
//    if (stickerViews) {
//        <#statements#>
//    }
//    
    return nil;
}
@end
