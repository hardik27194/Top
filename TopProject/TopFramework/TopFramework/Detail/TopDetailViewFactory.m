//
//  TopDetailViewFactory.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopDetailViewFactory.h"

static NSDictionary *details;

@implementation TopDetailViewFactory
+(void)load{
    details = @{@"default":@"DetailViewTmpl0"};
    
}
+(TopDetailView *)detailViewFromIdentifier:(NSString *)identifier{
    
    if(identifier == nil){
        return nil;
    }
    NSString *detailViewNibName = details[identifier];
    if (detailViewNibName == nil) {
        detailViewNibName = details[@"default"];
    }
    
    TopDetailView *detailView = [TopDetailView detailViewWithIdentifier:detailViewNibName];
    return detailView;
}
@end
