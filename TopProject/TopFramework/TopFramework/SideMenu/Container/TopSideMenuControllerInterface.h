//
//  TOPIControllerInterface.h
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#ifndef TOPIControllerInterface_h
#define TOPIControllerInterface_h
@protocol TopSideMenuControllerProtocol <NSObject>
-(void)TOPSMControllerOpenMenu;
-(void)TOPSMControllerCloseMenu;

@end

@protocol TopSideMenuControllerInterface <NSObject>
@property (nonatomic,assign) id<TopSideMenuControllerProtocol> delegate;
@end


#endif /* TOPIControllerInterface_h */
