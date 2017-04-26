//
//  _TopStickerControllerProtocol.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

@import UIKit;

#ifndef _TopStickerControllerProtocol_h
#define _TopStickerControllerProtocol_h
@protocol TopStickerControllerProtocol;

@protocol TopStickerControllerActions <NSObject>
- (void)askRefreshFromStickerController:(id <TopStickerControllerProtocol>)stickerController;
@end

@protocol TopStickerControllerProtocol <NSObject>
@property (nonatomic,weak) id <TopStickerControllerActions> stickerControllerDelegate;
- (UIViewController *)currentController;
- (void)enumCurrentControllers:(void(^)(UIViewController *controller))controllersBlock;
- (void)refresh;
@end

#endif /* _TopStickerControllerProtocol_h */
