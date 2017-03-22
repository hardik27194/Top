//
//  TOPIControllerInterface.h
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#ifndef TOPIControllerInterface_h
#define TOPIControllerInterface_h
@protocol TOPSMIControllerProtocol <NSObject>
-(void)TOPSMControllerOpenMenu;
-(void)TOPSMControllerCloseMenu;
@end

@protocol TOPSMIControllerInterface <NSObject>
@property (nonatomic,assign) id<TOPSMIControllerProtocol> delegate;
@end


#endif /* TOPIControllerInterface_h */
