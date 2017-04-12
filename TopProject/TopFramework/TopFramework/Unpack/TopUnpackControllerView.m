//
//  TopUnpackControllerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopUnpackControllerView.h"
#import "TopControllersDirector.h"
#import "TopPacketsDirector.h"
#import "TopAppDelegate.h"
#import "TopTileSticker.h"
#import "TopStickSessionDirector.h"
@interface TopUnpackControllerView ()

@property (nonatomic,strong) NSArray <NSString *> *rects;
@end

@implementation TopUnpackControllerView
+ (id)unPackView {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class])
                                bundle:[NSBundle bundleForClass:[self class]]];
    TopUnpackControllerView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        dismiss.backgroundColor = [UIColor whiteColor];
        [dismiss setTitle:@"dismiss" forState:UIControlStateNormal];
        [dismiss setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        dismiss.frame = CGRectMake(10, 10, 100, 50);
        dismiss.layer.cornerRadius = 10;
        dismiss.layer.borderColor = [UIColor blackColor].CGColor;
        dismiss.layer.borderWidth = 2;
        [dismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dismiss];
        UIButton *unpack = [UIButton buttonWithType:UIButtonTypeCustom];
        unpack.backgroundColor = [UIColor whiteColor];
        [unpack setTitle:@"unpack" forState:UIControlStateNormal];
        [unpack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        unpack.frame = CGRectMake(90, 80, 200, 200);
        unpack.layer.cornerRadius = 10;
        unpack.layer.borderColor = [UIColor blackColor].CGColor;
        unpack.layer.borderWidth = 2;
        [unpack addTarget:self action:@selector(unpack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:unpack];
        UIButton *stick = [UIButton buttonWithType:UIButtonTypeCustom];
        stick.backgroundColor = [UIColor whiteColor];
        [stick setTitle:@"stick" forState:UIControlStateNormal];
        [stick setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        stick.frame = CGRectMake(100, 10, 100, 50);
        stick.layer.cornerRadius = 10;
        stick.layer.borderColor = [UIColor blackColor].CGColor;
        stick.layer.borderWidth = 2;
        [stick addTarget:self action:@selector(stick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:stick];
        
  
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.sticker1.alpha = 0;
    self.sticker2.alpha = 0;
    self.sticker3.alpha = 0;
    self.sticker4.alpha = 0;
    self.sticker5.alpha = 0;
    
    self.rects = @[NSStringFromCGRect(self.sticker1.frame),
                   NSStringFromCGRect(self.sticker2.frame),
                   NSStringFromCGRect(self.sticker3.frame),
                   NSStringFromCGRect(self.sticker4.frame),
                   NSStringFromCGRect(self.sticker5.frame)];
}

-(IBAction)dismiss{
    [[TopControllersDirector sharedDirector] dismissUnPackController:self];

}
- (IBAction)unpack{

   [[TopPacketsDirector sharedDirector] createNewPacket:^(TopPacket *packet) {
       NSMutableArray <TopTileSticker *> *stickers = [[NSMutableArray alloc]init];
       for (NSNumber *stickerNumber in [packet stickers]) {
           TopTileSticker *sticker = [[TopTileSticker alloc]initWithFrame:CGRectMake(50, 400, 100, 100) andNumber:[stickerNumber integerValue]];
           sticker.center = self.unpackButton.center;
           
           [stickers addObject:sticker];
       }
       [[TopStickSessionDirector sharedDirector] startSessionWithTileStickers:stickers animation:^{
           NSInteger index = 0;
           for (TopTileSticker *sticker in stickers) {
               sticker.alpha = 0;
               if (index<self.rects.count) {
                   [self animateTile:sticker toRect:CGRectFromString(self.rects[index])];
               }
               index++;
           }
       }];
   } type:TopPacketType_Legendary];
}
-(void)animateTile:(TopTileSticker *)tileSticker
            toRect:(CGRect)rect{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        tileSticker.frame = rect;
        tileSticker.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
-(IBAction)autoloadDoubles{
    [[TopStickSessionDirector sharedDirector] autoLoadsDoublesCompletion:^{
        [[TopControllersDirector sharedDirector] dismissUnPackController:self];
    }];
}


@end
