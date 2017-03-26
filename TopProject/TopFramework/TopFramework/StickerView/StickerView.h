//
//  StickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopObject.h"

@interface StickerView : UIView
@property (nonatomic,strong) NSArray *numberStickers;
-(void)updateFromTopObject:(TopObject *)topObject withNumbers:(NSArray *)numbers;
-(void)updateNumber:(NSNumber *)number ifFounded:(BOOL)found;
@end
