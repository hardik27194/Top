//
//  CCell.m
//  Top
//
//  Created by Jacopo Pappalettera on 18/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "CCell.h"

@implementation CCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    self.image.layer.masksToBounds = YES;
    self.desc.textAlignment = NSTextAlignmentCenter;
}
-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    attributes.size = [self systemLayoutSizeFittingSize:layoutAttributes.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    return attributes;
}

@end
