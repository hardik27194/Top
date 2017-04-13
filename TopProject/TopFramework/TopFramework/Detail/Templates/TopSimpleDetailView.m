//
//  TopSimpleDetailView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 13/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopSimpleDetailView.h"

@implementation TopSimpleDetailView
-(void)updateStyle{
    self.backgroundColor = [UIColor whiteColor];
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.layer.masksToBounds = YES;
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)willShrink{
    self.titleLabel.alpha = 0;
    self.descriptionLabel.alpha = 0;
}
-(void)shrink{
    [super shrink];
    self.backgroundColor = self.shrinkedView.backgroundColor;
}

- (void)expand{
    [super expand];
    NSInteger offsetY = 10;
    self.imageView.frame = CGRectMake(10, offsetY, self.frame.size.width-20, 400);
    offsetY+=self.imageView.bounds.size.height;
    
    self.titleLabel.frame = CGRectMake(10, offsetY,self.frame.size.width-20, 70);
    
    offsetY+=self.titleLabel.bounds.size.height;
    
    self.descriptionLabel.frame = CGRectMake(10, offsetY,self.frame.size.width-20, self.frame.size.height-offsetY-10);
    
    
    self.backgroundColor = [UIColor whiteColor];

    self.titleLabel.alpha = 1;
    self.descriptionLabel.alpha = 1;
}
@end
