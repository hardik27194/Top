//
//  TopUnpackControllerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUnpackControllerView : UIView

@property (nonatomic,weak) IBOutlet UIView *sticker1;
@property (nonatomic,weak) IBOutlet UIView *sticker2;
@property (nonatomic,weak) IBOutlet UIView *sticker3;
@property (nonatomic,weak) IBOutlet UIView *sticker4;
@property (nonatomic,weak) IBOutlet UIView *sticker5;
@property (nonatomic,weak) IBOutlet UIButton *unpackButton;


+ (id)unPackView;
@property (nonatomic, copy) void (^endingBlock)(id data);
@end
