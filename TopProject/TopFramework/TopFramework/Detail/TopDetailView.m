//
//  TopDetailView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopDetailView.h"

@implementation TopDetailView
+ (id)detailViewWithIdentifier:(NSString *)identifier {
    UINib *nib = [UINib nibWithNibName:identifier
                                bundle:[NSBundle bundleForClass:[self class]]];
    TopDetailView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    return view;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.detailProtocol topDetailView:self askCloseWithData:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
