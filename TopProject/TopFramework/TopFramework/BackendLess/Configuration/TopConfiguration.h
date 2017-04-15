//
//  TopConfiguration.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 08/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopConfiguration : NSObject
@property (nonatomic,strong) NSString *detailViewId;
@property (nonatomic,strong) NSString *stickerViewId;
@property (nonatomic,assign) BOOL menuCategories;
@property (nonatomic,assign) BOOL useBgImage;
@end
@interface TopIPhoneConfiguration : TopConfiguration

@end
@interface TopIPadConfiguration : TopConfiguration

@end
