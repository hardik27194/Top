//
//  CCell.h
//  Top
//
//  Created by Jacopo Pappalettera on 18/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCell : UICollectionViewCell
@property (nonatomic,weak) IBOutlet UILabel *title;
@property (nonatomic,weak) IBOutlet UIImageView *image;
@property (nonatomic,weak) IBOutlet UILabel *desc;
@property (nonatomic,weak) IBOutlet UILabel *number;

@end
