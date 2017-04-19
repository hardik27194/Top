//
//  TopDetailViewFactory.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopDetailViewFactory.h"
#import "TopSimpleDetailView.h"

static NSDictionary *details;

@implementation TopDetailViewFactory
+(void)load{
    details = @{@"default":[TopSimpleDetailView class]};
    
}
+(TopDetailView *)detailViewFromIdentifier:(NSString *)identifier andFrame:(CGRect)frame{
    
    if(identifier == nil){
        return nil;
    }
    Class detailViewClass = details[identifier];
    if (detailViewClass == nil) {
        detailViewClass = details[@"default"];
    }
    
    TopDetailView *detailView = [[detailViewClass alloc]initWithFrame:frame];
    return detailView;
}
@end
