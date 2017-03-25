//
//  TopAccount.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 24/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TopUser : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *created;
@property (nonatomic,strong) NSString *lastLogin;

+(TopUser *)initializeAccountWithData:(NSDictionary *)userData;

@end
