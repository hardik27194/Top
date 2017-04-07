//
//  TopBarButton.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBarButton : UIButton
@property (nonatomic,weak) UILabel *iconLabel;
@property (nonatomic,weak) UILabel *valueLabel;
-(void)update;
@end
